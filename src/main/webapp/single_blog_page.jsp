<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.* , com.techblog.entities.* , com.techblog.dao.* " %>
<%@page import="org.springframework.context.annotation.AnnotationConfigApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>

<%!
    User user = null ; 
    User blogUser= null ;
    UserFullDetail userDetails = null ; 
    Blog blog = null  ; 
    boolean isAlreadyLiked = false; 
    int blogLikeCount = 0 ; 
    Like like = null ;
    List<Comment> comments = null ; 
    List<Like> likes = null ; 
    CommentDao commentDao = null ; 
    UserDao userDao = null ; 
%>

<%
    if (session == null || 
        session.getAttribute("user") == null || 
        request.getParameter("blog_id") == null) {
        response.sendRedirect("login") ; 
    }
    else {

        user = (User) session.getAttribute("user") ; 
        
        ApplicationContext ctx = new AnnotationConfigApplicationContext("com/techblog/dao") ; 
        BlogDao blogDao = ctx.getBean("BlogDao", BlogDaoImpl.class) ;
        userDao = ctx.getBean("UserDao", UserDaoImpl.class) ;
        LikeDao likeDao = ctx.getBean("LikeDao", LikeDaoImpl.class) ; 
        commentDao = ctx.getBean("CommentDao", CommentDaoImpl.class) ;

        blog = blogDao.getBlogByBlogId(Integer.parseInt(request.getParameter("blog_id"))) ;
        blogUser = userDao.getUserById(blog.getUser_id()) ;
        userDetails = userDao.getUserFullDetailByUserId(blog.getUser_id()) ;

        if (blog == null) {
            response.sendRedirect("login") ; 
        }
 
        like = likeDao.getLikeByBlogIdAndUserId(blog.getBlog_id(), user.getUser_id()) ;

        if (like != null) {
            isAlreadyLiked= true ; 
        }

        likes = likeDao.getLikesByBlogId(blog.getBlog_id()) ;
        if (likes != null) {
            blogLikeCount = likes.size() ; 
        }

        comments = commentDao.getCommentsByBlogId(blog.getBlog_id()) ;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= blog.getBlog_title()%> | TechBlog</title>
    <link rel="stylesheet" href="styles/index.css">
    <link rel="stylesheet" href="js/prism/prism.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/05981e6d7e.js" crossorigin="anonymous"></script>

    <style>
        .bg-primary-local,
        .swal-button {
    background-color: rgb(50, 50, 77);
    /* color: red; */
}
    .btn-primary {
        --bs-btn-bg: #32324d;
        --bs-btn-border-color: #32324d;
        --bs-btn-hover-color: #fff;
        --bs-btn-hover-bg: #47476c;
        --bs-btn-hover-border-color: #46466c;
    }
    </style>
</head>
<body>

    <%@include file="navbar.jsp"%>


    <div class="container my-3">

        <!-- blog title -->
        <div class="row" style="background-color: rgb(50, 50, 77); border-radius: 2px; color: white;">
            <span class="badge bg-dark text-light  position-relative top-0 start-100 translate-middle" style="width: 70px; overflow-x: scroll; color: white;"><%= blog.getBlog_tag()%></span>
            <div class="col-md-12 display-6 p-2">
                <b><%= blog.getBlog_title() %></b>
            </div>
        </div>

        <!-- author and data creayed -->
        <div class="row py-3" >
            <div class="col-md-8">
                <b><i>Author : </i></b>
                <i style="color: grey;"><%= blogUser.getUser_name()%></i> 
                <img src="images/<%= userDetails.getUser_img()%>" alt="img" style="height: 45px; width: 45px; border-radius: 50%">
            </div>
            <div class="col-md-4" style="text-align: right;">
                <b><i>Created at :</i></b> <span style="color: grey;">
                    <i><%= blog.getBlog_created_at()%></i>
                </span>
            </div>
        </div>


        <!-- like section -->
        <div class="row">
            <div class="col-md-8" style="text-align: left;">
                <span id="like-loader" class="fa fa-circle-o-notch fa-spin fa-1.5x"></span>
                <a id="like-button" href="#" style="text-decoration: none; color: rgb(50, 50, 77);">
                    <%
                        if (isAlreadyLiked == false) {
                        %>
                            <span id="like-button-symbol" class="fa fa-thumbs-up fa-2x"></span>
                        <%
                        }
                        else {
                        %>
                            <span id="like-button-symbol" class="fa fa-thumbs-down fa-2x"></span>
                            <br>
                            <span style="font-size: 10px; color: gray;">
                                <b>liked at </b> 
                                <%= like.getLiked_at()%>
                            </span>
                        <%
                        }
                    %>
                    
                </a>
            </div>
            <div class="col-md-4" style="text-align: right; font-size: 16px; cursor: pointer;" >
                <b style="cursor: pointer;" data-bs-toggle="modal" data-bs-target="#LikesModal"><i><%= blogLikeCount%> Likes</i></b>
            </div>
        </div>


        <hr>

        <!-- blog content -->
        <b><i>Content :</i></b>
        <div class="row p-3" style="text-align: justify;">
            <%= blog.getBlog_content()%>
        </div>

        <!-- blog code content only view if programing blog -->
        <%
            if (blog.getBlog_tag().equals("programming")) {
                %>
                <hr>
                <b><i>Code :</i></b>
                <div class="row">
                    <pre>
                        <code class="language-java">
                            <%= blog.getBlog_code_content() %>
                        </code>
                    </pre>
                </div>
                <%
            }
        %>


        <!-- user comment section -->
        <hr>
        <div class="container-fluid p-5" style="background-color: rgb(50, 50, 77);  border-radius: 2px;">
            
            <!-- viewer comment section -->
            <div class="row">
                <textarea id="comment-content" class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 100px"></textarea>
                <button id="add-comment-btn" class="btn btn-light btn-sm mt-2">
                    <span class="fa fa-comment"></span>    
                    Comment
                </button>
            </div>


            <!-- all comments section [will bring all comments using jsp] -->
            <div class="row my-5 py-3">
                <b><i><span style="color: white;">Comments
                    <span class="fa fa-comments-o"></span>
                </span></i></b>
                <hr style="color: whitesmoke;">

                <!-- will bring all comments here -->

                <div id="all-comments-section" class="container-fluid mt-3">


                    <%
                        if (comments.size() >= 1) {

                            for (Comment comment: comments) {

                                User commentUser = userDao.getUserById(comment.getUser_id()) ;
                                UserFullDetail commentUserDetails = userDao.getUserFullDetailByUserId(comment.getUser_id()) ;

                            %>
                                <!-- individual comment -->
                                <div class="comment mt-2 mb-2 pt-2" style="background-color: white; border-radius: 4px;">
                                    <div id="user-time-block" class="row">
                                        <div class="col-md-8 mx-2 my-1" style="padding-left: 15px;">
                                            <span style="color: rgb(102, 102, 102); font-size: 12px;"><%= commentUser.getUser_name()%></span> 
                                            <span><img src="images/<%= commentUserDetails.getUser_img()%>" alt="img" style="height: 33px; width: 33px; border-radius: 50%;"></span>
                                        </div>
                                        <div class="col-md-3 my-auto" style="color: rgb(102, 102, 102); font-size: 12px; padding-left: 30px;">
                                            Comment at <%= comment.getCommented_at()%>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-2"></div>
                                            <div class="col-md-10 p-3 mb-2" style="min-height: 4rem; background-color: rgba(223, 223, 223, 0.76); border-radius: 3px; font-size: 13px;">
                                                <%= comment.getComment_content()%>
                                            </div>
                                        </div>

                                        <%
                                            if (user.getUser_id() == commentUser.getUser_id()) {
                                            %>
                                                <div id="edit-delete-section" class="row py-2 px-5">
                                                    <div class="col-md-10"></div>
                                                    <div class="col-md-2">
                                                        <span>
                                                            <button id="comment-edit-btn" class="btn btn-primary btn-sm"  data-bs-toggle="modal" data-bs-target="#editCommentModal<%= comment.getComment_id()%>">Edit</button>
                                                            <button id="comment-delete-btn" class="btn btn-primary btn-sm" onclick="deleteComment(<%= comment.getComment_id()%>)">Delete</button>
                                                        </span>
                                                    </div>
                                                </div>    
                                            <%
                                            }
                                        %>

                                    </div>

                                    <!-- edit comment modal - start -->

                                    <div class="modal fade" id="editCommentModal<%= comment.getComment_id()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="mb-3">
                                                    <textarea class="form-control" id="edit-comment-content-<%= comment.getComment_id()%>" rows="3"><%= comment.getComment_content()%></textarea>
                                                </div>
                                            </div>
                                            <div class="modal-footer" id="modal-footer">
                                                <button onclick="saveEdit(<%= comment.getComment_id()%>)" id="comment-edit-save-btn" type="button" class="btn btn-primary btn-sm" data-bs-dismiss="modal">Save changes</button>
                                            </div>
                                            </div>
                                        </div>
                                    </div>
    
                                    <!-- edit comment modal - end -->

                                </div>
                                <!-- individual comment end-->

                            <%
                            }
                        }
                    %>


                    <!-- users likes view Modal -->

                    <div class="modal fade" id="LikesModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                            <h5 class="modal-title text-center" id="exampleModalLabel">Likes</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <table class="table">
                                    <tbody>

                                      <%
                                        if (likes.size() == 0) {
                                            %>
                                            <tr>
                                                <td class="text-center">No likes yet</td>
                                            </tr>
                                            <%
                                        }
                                        else {
                                            int ind = 1 ; 
                                            for (Like userLike : likes) {

                                                User likeUser = userDao.getUserById(userLike.getUser_id()) ;
                                                UserFullDetail likeUserDetails = userDao.getUserFullDetailByUserId(userLike.getUser_id()) ;

                                                %>
                                                <tr>
                                                    <th scope="row" style="font-size: 13px;"><%= ind%></th>
                                                    <td><span style="font-size: 13px;"><%= likeUser.getUser_name()%></span> <span><img src="images/<%= likeUserDetails.getUser_img()%>" alt="img" style="height: 20px; width: 20%;"></span></td>
                                                    <td><span style="color: gray; font-size: 13px;"><%= likeUser.getUser_email()%></span></td>
                                                    <td><span style="color: gray; font-size: 13px;"><%= userLike.getLiked_at()%></span></td>
                                                </tr>
                                                <%

                                                ind++ ; 
                                            }
                                        }
                                      %>


                                    </tbody>
                                  </table>
                            </div>
                        </div>
                        </div>
                    </div>
  
                    <!-- users likes view Modal - end -->


                </div>

            </div>

        </div>



    </div>


    <%@include file="footer.jsp"%>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"
        integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script src="js/prism/prism.js"></script>


    <script>


        const hideBtn = (this) => {
            $(this).hide() ; 
        }


        const showBtn = (this) => {
            $(this).show() ; 
        }


        const deleteComment = (commentId) => {
            $("#comment-delete-btn").hide() ;
            $.ajax({
                url : "comment" , 
                type : "POST", 
                data : {
                    "comment-type" : "delete-comment" , 
                    "comment-id" : commentId
                }, 
                success : data => {
                    if (data == "success") {
                        swal({
                            text: "comment successfully deleted..." , 
                            icon: "success"
                        }).then(val => {
                            $("#comment-delete-btn").show() ;
                            window.location.reload() ;
                        })
                    }
                    else {
                        swal({
                            text: data, 
                            icon: "warning" 
                        }).then( val=> {
                            $("#comment-delete-btn").show() ;
                        })
                    }
                },
                error : data => {
                    swal({
                        text: "error deleting comment..." ,
                        icon: "warning"
                    }).then(val => {
                        $("#comment-delete-btn").show() ;
                    })
                }
            })

        }

 
        const saveEdit = (commentId) => {
            $("#modal-footer").hide() ; 
            $("#comment-edit-btn").hide() ; 
            $.ajax({

                url: "comment" , 
                type: "POST" , 
                data : {
                    "comment-type" : "edit-comment", 
                    "comment-id" : commentId , 
                    "comment-content" : $("#edit-comment-content-"+commentId).val() 
                },
                success : data => {
                    if ( data == "success") {
                        swal({
                            text: "successfully edited comment..." , 
                            icon: "success"
                        }).then(val => {
                            window.location.reload() ;
                        });
                    }
                    else {
                        swal({
                            text : data , 
                            icon : "warning"
                        }); 
                        $("#modal-footer").show() ;
                        $("#comment-edit-btn").show() ; 
                    }
                },
                error : data => {
                    swal({
                        text: "edit error!!!" ,
                        icon: "warning"
                    }); 
                    $("#modal-footer").show() ;
                    $("#comment-edit-btn").show() ; 
                }

            })
        }





        // on ajax load => 

        $(document).ready(() => {

            let isLiked = <%= isAlreadyLiked%> ; 

            $("#like-loader").hide() ;

            $("#like-button").click(e => {
                
                e.preventDefault() ; 

                $("#like-loader").show() ;
                $("#like-button").hide() ;

                if (!isLiked) {
                    console.log("ready to like") ; 

                    // make ajax req to like
                    $.ajax({

                        url: "like" , 
                        type: "POST" , 
                        data: {
                            "like-type" : "like" , 
                            "user-id" : "<%= user.getUser_id()%>" , 
                            "blog-id" : "<%= blog.getBlog_id()%>"
                        }, 
                        success: data => {
                            if (data == "success") {
                                isLiked = true ;
                                <%
                                    isAlreadyLiked = true ;
                                %> 
                                swal({
                                    text: "you liked this blog..." , 
                                    icon: "success" 
                                }).then(val => {
                                    $("#like-button-symbol").removeClass("fa-thumbs-up") ;
                                    $("#like-button-symbol").addClass("fa-thumbs-down") ;
                                    window.location.reload() ;
                                });
                                 
                            }
                            else {
                                swal({
                                    text: data , 
                                    icon: "warning" 
                                });
                            }
                            $("#like-loader").hide() ;
                            $("#like-button").show() ;
                        }, 
                        error: data => {
                            swal({
                                text: "error!!" , 
                                icon: "warning"
                            });
                            $("#like-loader").hide() ;
                            $("#like-button").show() ;
                        }

                    })
                   
                }
                else {

                    console.log("ready to dislike") ; 
                    
                    
                    // make ajax req to dislike
                    $.ajax({

                        url: "like" , 
                        type: "POST" , 
                        data: {
                            "like-type" : "dislike" , 
                            "user-id" : "<%= user.getUser_id()%>" , 
                            "blog-id" : "<%= blog.getBlog_id()%>"
                        }, 
                        success: data => {
                            if (data == "success") {
                                isLiked = false ;
                                <%
                                    isAlreadyLiked = false ;
                                %>  
                                swal({
                                    text: "you disliked this blog..." , 
                                    icon: "success" 
                                }).then(val => {
                                    $("#like-button-symbol").addClass("fa-thumbs-up") ;
                                    $("#like-button-symbol").removeClass("fa-thumbs-down") ;
                                    window.location.reload() ;
                                })

                            }
                            else {
                                swal({
                                    text: data , 
                                    icon: "warning" 
                                });
                            }
                            $("#like-loader").hide() ;
                            $("#like-button").show() ; 
                        }, 
                        error: data => {
                            swal({
                                text: "error!!" , 
                                icon: "warning"
                            });
                            $("#like-loader").hide() ;
                            $("#like-button").show() ;
                        }

                   }) 

                }
            })



            // script for adding comment

            $("#add-comment-btn").click(e => {

                e.preventDefault() ; 
                $("#add-comment-btn").hide() ;

                // make ajax request to comment handler

                $.ajax({

                    url: "comment" , 
                    type: "POST" , 
                    data: {
                        "comment-type" : "add-comment" , 
                        "user-id" : "<%= user.getUser_id()%>" , 
                        "blog-id" : "<%= blog.getBlog_id()%>" , 
                        "comment-content" : $("#comment-content").val() 
                    }, 
                    success: data => {
                        if (data == "success") {
                            swal({
                                text: "commment added successfully..." , 
                                icon: "success"
                            })
                            .then(val => {
                                $("#add-comment-btn").show() ;
                                window.location.reload() ; 
                            });
                        }
                        else {
                            swal({
                                text: data , 
                                icon: "warning"
                            })
                            .then(val => {
                                $("#add-comment-btn").show() ;
                            });
                        }
                    },
                    error: data => {
                        swal({
                            text: "error uploading comment...", 
                            icon: "warning"
                        }).then(val => {
                            $("#add-comment-btn").show() ;
                        });
                    }

                })


            })


        })


    </script>

</body>
</html>