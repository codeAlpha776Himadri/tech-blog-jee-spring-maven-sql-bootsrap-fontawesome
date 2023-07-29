<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.techblog.entities.*" %>

<%!
    String userName ;  
%>

<%
    if (session.getAttribute("user") != null) {
        User user = (User) session.getAttribute("user") ;
        userName = user.getUser_name() ; 
    }
    else {
        userName = "Profile" ;
    }
%>

<style>
    .bg-primary-local, 
    .swal-button {
background-color: rgb(50, 50, 77);
/* color: red; */
}
</style>

<nav class="navbar navbar-expand-lg  navbar-dark bg-primary-local">
    <div class="container-fluid">
        <a class="navbar-brand" href="home">Tech Blog</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link " aria-current="page" href="home"> <span class="fa-solid fa-house"
                            style="color: white;"></span> Home</a>
                </li>

                <%
                    if (session.getAttribute("user") == null) {

                        %>
                        
                            <li class="nav-item" style="cursor: pointer;">
                                <a class="nav-link" href="login">
                                    <span class="fa fa-user-circle-o" style="color: white;"></span>
                                    Login</a>
                            </li>
                            <li class="nav-item" style="cursor: pointer;">
                                <a class="nav-link" href="signup">
                                    <span class="fa fa-user-plus" style="color: white;"></span>
                                    Signup</a>
                            </li>
                        
                        <%
                    }
                    else {
                        %>
                            <li class="nav-item" style="cursor: pointer;">
                                <a class="nav-link" href="blog">
                                    <span class="fa fa-reorder" style="color: white;"></span>
                                    Blogs</a>
                            </li>

                            <li class="nav-item" style="cursor: pointer;">
                                <a class="nav-link" data-bs-toggle="modal" data-bs-target="#exampleModal" href="">
                                    <span class="fa fa-plus" style="color: white;"></span>
                                    New Blog</a>
                            </li>
                        <%
                    }
                %>

            </ul>
            
            <%
                if (session.getAttribute("user") == null) {
                    %>
                        <form action="#" method="POST" class="d-flex" role="search">
                            <input class="form-control me-2" type="search" name="search-text" placeholder="Search" aria-label="Search">
                            <button class="btn btn-outline-light" type="submit">Search</button>
                        </form>
                    <%
                }
                else {
                    %>
                        <ul class="navbar-nav mb-2 mb-lg-0 ml-4">
                            <li class="nav-item" style="cursor: pointer;">
                                <a class="nav-link" href="profile">
                                    <span class="fa fa-user" style="color: white;"></span>
                                        <%= userName%>
                                    </a>
                            </li>
                            <li class="nav-item">
                                <a id="logout-btn" class="nav-link" href="Logout"> <span class="fa fa-power-off" style="color: white;"></span>
                                    Logout</a>
                            </li>
                        </ul>
                    <%
                }
            %>

        </div>
    </div>
</nav>

<%@include file="create_blog.jsp"%>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"
                        integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
                        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
                        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        

<script>

    $(document).ready(() => {

        $("#logout-btn").click(e => {

            e.preventDefault() ; 
            swal({
                text: "Are you sure logging out ?",
                buttons : {
                    cancel: {
                        text: "Cancel",
                        value: null,
                        visible: false,
                        className: "",
                        closeModal: true,
                    },
                    confirm: {
                        text: "Logout",
                        value: true,
                        visible: true,
                        className: "",
                        closeModal: true
                    }
                }
            }).then(val => {
                if (val) {
                    // make the ajax req to logout servlet
                    $.ajax({
                        url: "Logout", 
                        type: "POST" , 
                        data: {}, 
                        success: (data) => {
                            if (data == "successfully logged out...") {
                                window.location.href="login"
                            }
                        },
                        error: (data) => {
                            swal("Error logging out!!") ;
                        }
                    })
                }
            })

        })


        // add blog 

            $("#blog-upload-btn").click(e => {

            e.preventDefault() ; 

            var blog_title= $("#blog-title").val() ;
            var blog_tag = $("#blog-tag").val() ; 
            var blog_content = $("#blog-content").val() ; 
            var blog_code_content = $("#blog-code-content").val() ; 

            console.log({
                blog_title, blog_tag, blog_content, blog_code_content
            })


            // make ajax req to servlet to save to db

            $.ajax({

                url: "blog/new" , 
                type: "POST" , 
                data : {
                    "blog-title": blog_title, 
                    "blog-tag": blog_tag, 
                    "blog-content": blog_content , 
                    "blog-code-content": blog_code_content
                },
                timeout: 50000 , 
                success: data => {

                    if (data == "success...") {
                        swal({
                        text: "Blog added..." , 
                        icon: "success"
                        }).then (val => {
                            window.location.reload() ;
                        })
                    }
                    else {
                        swal({
                        text: data , 
                        icon: "warning"
                        }) ;
                    }

                }, 
                error: data => {
                    swal({
                        text: data , 
                        icon: "warning"
                    });
                }

            // end of ajax call 
            })


            })

    })

</script>

