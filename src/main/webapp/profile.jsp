<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.techblog.entities.*" %>

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
            height: 92px;
            width: 92px;
            border-radius: 50%;
        }
    </style>
</head>
<body>
    
    <!-- navbar -->

     <%@include file="navbar.jsp"%>



    <%-- profile content --%>

    
    <div class="container py-5">
        
        <div class="row">

            <div class="col-md-8 offset-2">

                <div class="card" style="color: rgb(50, 50, 77);">

                    <div class="card-header text-center py-3">
                        <!-- <%= userDetails.getUser_img()%> -->
                        <img id="preview" src="images/<%= userDetails.getUser_img()%>" alt="img" >
                        
                        <div id="img-update-btn" class="mt-2"  data-bs-toggle="modal" data-bs-target="#upload-img-modal"><a href="#"><span class="fa fa-edit">

                        </span></a></div>
                        
                    </div>

                    <div class="card-title text-center mt-2">

                        <b id="username" style="font-size: 18px;"><%= user.getUser_name()%> <span id="username-update-btn"><a href="#"><span class="fa fa-edit"></span></a></span></b>

                    </div>

                    <div class="card-body pt-2">

                        <table class="table">
                            <tbody>
                              <tr>
                                <th scope="row">Total Blogs : </th>
                                <td><%= blogsCount%></td>
                                <td></td>
                              </tr>
                              <tr>
                                <th scope="row">Full Name : </th>
                                <td id="fullname"><%= userDetails.getUser_full_name()%></td>
                                <td><a href="#"><span id="fullname-update-btn" class="fa fa-edit"></span></a></td>
                              </tr>
                              <tr>
                                <th scope="row">Email : </th>
                                <td  id="email"><%= user.getUser_email()%> </td>
                                <td><a href="#"><span id="email-update-btn" class="fa fa-edit"></span></a></td>
                              </tr>
                              <tr>
                                <th scope="row">Password : </th>
                                <td id="password">********</td>
                                <td><a href="#"><span id="password-update-btn" class="fa fa-edit"></span></a></td>
                              </tr>
                              <tr>
                                <th scope="row">Gender : </th>
                                <td><%= user.getUser_gender()%> </td>
                                <td></td>
                              </tr>
                              <tr>
                                <th scope="row">D.O.B : </th>
                                <td id="dob"><%= userDetails.getUser_dob()%></td>
                                <td><a href="#"><span id="dob-update-btn" class="fa fa-edit"></span></a></td>
                              </tr>
                              <tr>
                                <th scope="row">About me : </th>
                                <td>
                                    <div id="about" class="container-fluid p-2" style="max-height: 100px;  border: 1px solid rgb(184, 184, 184); border-radius: 3px; overflow-y: scroll;" >
                                        <%= userDetails.getUser_about_me()%>
                                    </div>
                                </td>
                                <td><a href="#"><span id="aboutme-update-btn" class="fa fa-edit"></span></a></td>
                              </tr>
                              <tr>
                                <th scope="row">Account <br>Created at : </th>
                                <td><%= user.getUser_created_at()%></td>
                                <td></td>
                              </tr>
                            </tbody>
                          </table>

                    </div>

                </div>

            </div>

        </div>

    </div>



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
            <button id="img-upload-btn" type="submit" form="img-upload" class="btn btn-primary"   data-bs-dismiss="modal">Save changes</button>
            </div>
        </div>
        </div>
    </div>





      
     
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

            console.log("jq active...") ;


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


        })


    </script>



</body>
</html>