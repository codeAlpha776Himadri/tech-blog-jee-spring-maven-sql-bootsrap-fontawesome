<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.* , com.techblog.entities.* , com.techblog.dao.* " %>
<%@page import="org.springframework.context.annotation.AnnotationConfigApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="java.lang.*"%>

<%!
    User user; 
    UserFullDetail userDetails ; 
    Integer blogsCount ;  
%>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login") ; 
    }
    else {
        user = (User) session.getAttribute("user") ;
        userDetails = (UserFullDetail) session.getAttribute("user-details") ;
        blogsCount = (Integer) session.getAttribute("blogs-count") ;
        
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile | <%= user.getUser_name()%></title>
    <link rel="stylesheet" href="styles/index.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/05981e6d7e.js" crossorigin="anonymous"></script>

    <style>
        .bg-primary-local,
        .swal-button {
            background-color: rgb(50, 50, 77);
            /* color: red; */
        }
        #profile-img::after {
            content: '';
            background: url("images/default_bg.png") no-repeat center center/cover;
            position: absolute;
            height: 100%;
            width: 100%;
            border-radius: 50%;
            top: 0;
            left: 0;
            z-index: -1;
            opacity: 1;
        }
        #profile-img:hover {
            transition: all 0.3s ease-in;
            opacity: 0.8;
        }
        #preview {
            height: 142px;
            width: 142px;
            border-radius: 50%;
        }
    </style>
</head>
<body>
    
    <!-- navbar -->

     <%@include file="navbar.jsp"%>


    <%-- new profile content --%>


    <section style="background-color: rgb(50, 50, 77);">
        <div class="container py-5">
          
      
          <div class="row">
            <div class="col-lg-4">
              <div class="card mb-4">
                <div class="card-body text-center">
                  <img id="preview" src="images/<%= userDetails.getUser_img()%>" alt="avatar"
                    class="rounded-circle img-fluid" >
                    <div class="img-edit">
                        <a href="#"><span id="image-update-btn"  data-bs-toggle="modal" data-bs-target="#upload-img-modal" class="fa fa-edit mar-left"></span></a> 
                    </div>
                  <h5 class="my-3" id="username"><%= user.getUser_name()%>
                    <a href="#"><span id="username-update-btn" class="fa fa-edit mar-left"></span></a> 
                  </h5>
                  
                  <p class="text-muted mb-1"><b><%= blogsCount%></b> Blogs</p>

                  
                  <div class="d-flex justify-content-center mb-2">
                    <button  type="button" class="btn btn-primary"  data-bs-toggle="modal" data-bs-target="#exampleModal"  style="background-color: rgb(50, 50, 77); border: none;">
                        New Blog
                    </button>
                    <button id="get-blogs-btn" type="button" class="btn btn-outline ms-1" style="border-color: rgb(50, 50, 77); color: rgb(50, 50, 77);">
                        Blogs
                    </button>
                  </div>
                </div>
              </div>
              <div class="card mb-4 mb-lg-0">
                <div class="card-body p-0">
                  <ul class="list-group list-group-flush rounded-3">
                    <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                      <i class="fas fa-globe fa-lg text-warning"></i>
                      <p class="mb-0">https://mdbootstrap.com</p>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                      <i class="fab fa-github fa-lg" style="color: #333333;"></i>
                      <p class="mb-0">mdbootstrap</p>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                      <i class="fab fa-twitter fa-lg" style="color: #55acee;"></i>
                      <p class="mb-0">@mdbootstrap</p>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                      <i class="fab fa-instagram fa-lg" style="color: #ac2bac;"></i>
                      <p class="mb-0">mdbootstrap</p>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                      <i class="fab fa-facebook-f fa-lg" style="color: #3b5998;"></i>
                      <p class="mb-0">mdbootstrap</p>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-lg-8">
              <div class="card mb-4">
                <div class="card-body">
                  <div class="row">
                    <div class="col-sm-3">
                      <p class="mb-0">Full Name</p>
                    </div>
                    <div class="col-sm-9">
                      <p class="text-muted mb-0" id="fullname"><%= userDetails.getUser_full_name()%><a href="#"><span id="fullname-update-btn" class="fa fa-edit mar-left"></span></a></p>
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <p class="mb-0">Email</p>
                    </div>
                    <div class="col-sm-9">
                      <p class="text-muted mb-0" id="email">
                        <%= user.getUser_email()%>
                        <a href="#"><span id="email-update-btn" class="fa fa-edit mar-left"></span></a> 
                    </p>
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <p class="mb-0">Password</p>
                    </div>
                    <div class="col-sm-9">
                      <p class="text-muted mb-0" id="password">********
                      <a href="#"><span id="password-update-btn" class="fa fa-edit mar-left"></span></a> 
                      </p>
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <p class="mb-0">Gender</p>
                    </div>
                    <div class="col-sm-9">
                      <p class="text-muted mb-0"><%= user.getUser_gender()%></p>
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <p class="mb-0">D.O.B</p>
                    </div>
                    <div class="col-sm-9">
                      <p class="text-muted mb-0" id="dob"><%= userDetails.getUser_dob()%>
                        <a href="#"><span id="dob-update-btn" class="fa fa-edit mar-left"></span></a> 
                      </p>
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <p class="mb-0">About</p>
                    </div>
                    <div class="col-sm-9">
                      <p id="about" class="text-muted mb-0"><%= userDetails.getUser_about_me()%><a href="#"><span id="aboutme-update-btn" class="fa fa-edit mar-left"></span></a></p>
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <p class="mb-0">Created at</p>
                    </div>
                    <div class="col-sm-9">
                      <p class="text-muted mb-0"><%= user.getUser_created_at()%>
                        <!-- <a href="#"><span id="about-update-btn" class="fa fa-edit mar-left"></span></a>  -->
                      </p>
                    </div>
                  </div>
                </div>
              </div>
              <br>

              
              <!-- Recent blogs -->

              <h5 style="margin-bottom: 1rem; color: white;">Recent Blogs</h5>
              
              <div class="row">

                <%
                
                ApplicationContext ctx = new AnnotationConfigApplicationContext("com/techblog/dao") ;
                
                BlogDao blogDao = ctx.getBean("BlogDao", BlogDaoImpl.class) ; 
                UserDao userDao = ctx.getBean("UserDao", UserDaoImpl.class) ; 
                LikeDao likeDao = ctx.getBean("LikeDao", LikeDaoImpl.class) ; 
                CommentDao commentDao = ctx.getBean("CommentDao", CommentDaoImpl.class) ; 
                
        
                List<Blog> allBlogs = blogDao.getAllBlogs() ; 

                for (Blog blog : allBlogs) {

                    User blogUser = userDao.getUserById(blog.getUser_id()) ;
                    UserFullDetail blogUserFullDetails = userDao.getUserFullDetailByUserId(blog.getUser_id()) ;
                    int likesCount = likeDao.getLikesByBlogId(blog.getBlog_id()).size() ;
                    int commentsCount = commentDao.getCommentsByBlogId(blog.getBlog_id()).size() ;

                    %>
                    
                      <!-- individual blog -->
                        <div class="col-md-12 mb-3">
                        
                            <div class="card">
                                <div class="card-header"><b><i><%= blog.getBlog_title()%></i></b></div>
                                <div class="row">
                                    <div class="col-md-4 text-center py-1">
                                        <span style="font-size: 12px; color: gray;"><%= blogUser.getUser_name()%></span>
                                        <span><img src="images/<%= blogUserFullDetails.getUser_img()%>" alt="img" style="height: 22px; width: 22px; border-radius: 50%;"></span>
                                    </div>
                                    <div class="col-md-4"></div>
                                    <div class="col-md-4 text-center pt-3">
                                        <span style="color: gray; font-size: 11px;"><%= blog.getBlog_created_at()%></span>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <%= blog.getBlog_content()%>
                                </div>
                                <div class="card-footer">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <a href="single_blog_page.jsp?blog_id=<%= blog.getBlog_id()%>" class="btn btn-primary btn-sm">Read more...</a>
                                        </div>
                                        <div class="col-md-5"></div>
                                        <div class="col-md-2 float-right">
                                            <span class="fa fa-thumbs-o-up"></span> <%= likesCount%>
                                        </div>
                                        <div class="col-md-2 float-left">
                                            <span class="fa fa-comment-o float-left"></span> <%= commentsCount%>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                    <%

                }

                %>



              </div>

              <!-- recent blogs end -->


            </div>
          </div>
        </div>
      </section>


    <%-- new profile content end --%>


    

    <!-- </div> -->


     <!-- Modal -->
     <div class="modal fade" id="upload-img-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="img-upload-form" action="UpdateUser" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="update-parameter" value="user-img">
                    <input type="file" name="profile-img" id="user-img" class="form-control">
                </form>
            </div>
            <div class="modal-footer">
            <button id="img-upload-btn" type="submit" form="img-upload" class="btn btn-primary btn-sm"   data-bs-dismiss="modal">Save changes</button>
            </div>
        </div>
        </div>
    </div>



    <%@include file="create_blog.jsp"%>


      
     
    <!-- footer -->

    <%@include file="footer.jsp"%>




    <script src="https://code.jquery.com/jquery-3.7.0.min.js"
        integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>




    <script>

        $(document).ready(() => {


            $("#get-blogs-btn").click(e => {
                e.preventDefault() ;
                window.location.href="blog" ; 
            }) ;


            $("#user-img").change(function() {
                readURL(this);
            });



            $("#img-upload-btn").click(e => {

                e.preventDefault() ;

                // make req to servlet save to db

                     
                // Build under progress -----
                
                console.log($("#img-upload-form")[0]) ;

                let data = new FormData($("#img-upload-form")[0]) ;
                data.append("update-parameter","user-img") ;
                data.append("update-value","form-data") ;

                console.log("form-data : ",data) ;
                
                $.ajax({

                    url: "UpdateUser" , 
                    type: "POST", 
                    data : data ,
                    success: data => {
                        if (data == "update success...") {
                            swal({
                                text: data , 
                                icon: "success"
                            })
                            .then(val => {
                                window.location.reload() ;
                            });
                        }
                        else {
                            swal({
                                text: data , 
                                icon: "warning"
                            });
                        }
                    },
                    error: data => {
                        console.log(data) ;
                        swal({
                            text: "error submitting form..." , 
                            icon: "warning"
                        });
                    },
                    processData: false , 
                    contentType: false 

                })
                

            });


            $("#username-update-btn").click(e => {

                e.preventDefault() ;
                const field = document.querySelector("#username") ;
                swal({
                    content: {
                        title: "Enter new username: " ,
                        element: "input",
                        attributes: {
                        placeholder: "type here...",
                        type: "text",
                        value: field.textContent
                        },
                    },
                    buttons: {
                        cancel: true,
                        confirm: true
                    }
                })
                .then(val => {

                    if (val) {

                        console.log(val) ;

                        // make ajax req to update in db

                        submitRequest("user-name",val) ;

                    }

                });
                
            })



            $("#fullname-update-btn").click(e => {

                e.preventDefault() ;
                const field = document.querySelector("#fullname") ;
                swal({
                    content: {
                        title: "Enter full name: " ,
                        element: "input",
                        attributes: {
                        placeholder: "type here...",
                        type: "text",
                        value: field.textContent
                        },
                    },
                    buttons: {
                        cancel: true,
                        confirm: true
                    }
                })
                .then(val => {

                    if (val) {

                        console.log(val) ;

                        submitRequest("user-full-name",val) ;

                    }

                });
                
            });



            $("#email-update-btn").click(e => {

                e.preventDefault() ;
                const field = document.querySelector("#email") ;
                swal({
                    content: {
                        title: "Enter new email: " ,
                        element: "input",
                        attributes: {
                        placeholder: "type here...",
                        type: "email",
                        value: field.textContent
                        },
                    },
                    buttons: {
                        cancel: true,
                        confirm: true
                    }
                })
                .then(val => {

                    if (val) {

                        console.log(val) ;

                        submitRequest("user-email",val) ;

                    }

                });
                
            })



            $("#password-update-btn").click(e => {

                e.preventDefault() ;
                
                swal({
                     content: {
                        title : "Please enter current password: ", 
                        element: "input", 
                        attributes : {
                            placeholder: "Please enter current password:" ,
                            type: "text" , 
                            value: "" 
                        }
                     }, 
                     buttons : {
                        cancel: true, 
                        confirm: true 
                     }
                })
                .then(val => {

                    if (val) {

                        if (val == "<%= user.getUser_password()%>") {
                            // correct 

                            const field = document.querySelector("#password") ;
                            swal({
                                content: {
                                    title: "Enter new password: " ,
                                    element: "input",
                                    attributes: {
                                        placeholder: "Enter new password:",
                                        type: "text"
                                    },
                                }, 
                                buttons: {
                                    cancel: true,
                                    confirm: true
                                }
                            })
                            .then(val => {

                                if (val) {

                                    submitRequest("user-password",val) ;

                                }

                            });

                        }
                        else {
                            swal({
                                text: "Passwords don't match! Try again!" ,
                                icon: "warning"
                            });
                        }

                    }

                })

            })



            $("#dob-update-btn").click(e => {

                e.preventDefault() ;
                const field = document.querySelector("#dob") ;
                swal({
                    content: {
                        title: "Enter DOB: " ,
                        element: "input",
                        attributes: {
                        placeholder: "type here...",
                        type: "date",
                        value: field.textContent
                        },
                    }, 
                    buttons: {
                        cancel: true,
                        confirm: true
                    }
                })
                .then(val => {

                    if (val) {

                        console.log(val) ;

                        submitRequest("user-dob",val) ;

                    }

                });
                
            })



            $("#aboutme-update-btn").click(e => {

                e.preventDefault() ;
                const field = document.querySelector("#about") ;
                swal({
                    content: {
                        title: "Enter about yourself: " ,
                        element: "input",
                        attributes: {
                        placeholder: "type here...",
                        type: "textarea",
                        value: field.textContent
                        },
                    },
                    buttons: {
                        cancel: true,
                        confirm: true
                    }
                })
                .then(val => {

                    if (val) {

                        console.log(val) ;

                        submitRequest("user-about-me",val) ;

                    }
 
                });
                
            })




            const submitRequest = (update_parameter,update_value) => {
                
                $.ajax({

                    url: "UpdateUser", 
                    type: "POST",
                    data: {
                        "update-parameter" : update_parameter, 
                        "update-value" : update_value   
                    }, 
                    timeout: 50000 , 
                    success: data => {
                        console.log("Response : "+data) ;
                        if (data == "update success...") {
                            swal({
                                text: "updated successfully..." ,
                                icon: "success"
                            })
                            .then(val => {
                                window.location.reload() ;
                            });
                        }
                    },
                    error: data => {
                        console.log("Response : "+data) ;
                        swal(data,"warning")
                        .then(val => {
                            window.location.reload() ;
                        });
                    }

                })
            }



            // file content reader - helper 

            const readURL = (input) => {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = e => {
                        $("#preview").attr("src", e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                    console.log("success") ;
                } else {
                    $('#preview').attr("src", "images/default.png");
                    console.log("Fail") ; 
                }
            }



            // add blog 

            // $("#blog-upload-btn").click(e => {

            // e.preventDefault() ; 

            // var blog_title= $("#blog-title").val() ;
            // var blog_tag = $("#blog-tag").val() ; 
            // var blog_content = $("#blog-content").val() ; 
            // var blog_code_content = $("#blog-code-content").val() ; 

            // console.log({
            //     blog_title, blog_tag, blog_content, blog_code_content
            // })


            // // make ajax req to servlet to save to db

            // $.ajax({

            //     url: "blog/new" , 
            //     type: "POST" , 
            //     data : {
            //         "blog-title": blog_title, 
            //         "blog-tag": blog_tag, 
            //         "blog-content": blog_content , 
            //         "blog-code-content": blog_code_content
            //     },
            //     timeout: 50000 , 
            //     success: data => {

            //         if (data == "success...") {
            //             swal({
            //             text: "Blog added..." , 
            //             icon: "success"
            //             }).then (val => {
            //                 window.location.reload() ;
            //             })
            //         }
            //         else {
            //             swal({
            //             text: data , 
            //             icon: "warning"
            //             }) ;
            //         }

            //     }, 
            //     error: data => {
            //         swal({
            //             text: data , 
            //             icon: "warning"
            //         });
            //     }

            // // end of ajax call 
            // })


            // })




        })


    </script>



</body>
</html>