<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.* , com.techblog.entities.* , com.techblog.dao.* " %>
<%@page import="org.springframework.context.annotation.AnnotationConfigApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>

<%!
    User user = null ; 
    User blogUser= null ;
    UserFullDetail userDetails = null ; 
    Blog blog = null  ; 
%>

<%
    if (session.getAttribute("user") == null || 
        request.getParameter("blog_id") == null) {
        response.sendRedirect("login") ; 
    }
    else {

        user = (User) session.getAttribute("user") ; 
        
        ApplicationContext ctx = new AnnotationConfigApplicationContext("com/techblog/dao") ; 
        BlogDao blogDao = ctx.getBean("BlogDao", BlogDaoImpl.class) ;
        UserDao userDao = ctx.getBean("UserDao", UserDaoImpl.class) ;

        blog = blogDao.getBlogByBlogId(Integer.parseInt(request.getParameter("blog_id"))) ;
        blogUser = userDao.getUserById(blog.getUser_id()) ;
        userDetails = userDao.getUserFullDetailByUserId(blog.getUser_id()) ;

        if (blog == null) {
            response.sendRedirect("login") ; 
        }
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
                <a href="#"><span class="fa fa-thumbs-up fa-2x"></span></a>
            </div>
            <div class="col-md-4" style="text-align: right; font-size: 16px;">
                <b><i>102 Likes</i></b>
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
                <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 100px"></textarea>
                <button class="btn btn-light btn-sm mt-2">
                    <span class="fa fa-comment"></span>    
                    Comment
                </button>
            </div>

            <!-- all comments section -->
            <div class="row my-5 py-3">
                <b><i><span style="color: white;">Comments
                    <span class="fa fa-comments-o"></span>
                </span></i></b>
                <hr style="color: whitesmoke;">
            </div>

        </div>



    </div>


    <%@include file="footer.jsp"%>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
    <script src="js/prism/prism.js"></script>
</body>
</html>