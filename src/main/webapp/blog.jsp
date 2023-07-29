<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.* , com.techblog.entities.* "%>

<%!
    User user = null ; 
%>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp") ; 
    }
    else {
        user = (User) session.getAttribute("user") ;
    }       
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blogs</title>
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
    .list-group-item.active {
    z-index: 2;
    color: #f8f8f8;
    background-color: #32324d;
    border-color: #32324d;
}
    </style>
    <style>
        #blog-cat {
            text-decoration: none;
            font-style: normal;
        }
    </style>
</head>
<body>
    
    <!-- navbar -->

     <%@include file="navbar.jsp"%>



    <%-- blog content --%>

    <div class="container my-3">


        <div class="row">

            <!-- catagories section -->
            <div class="col-md-3" style="min-height: 550px;">
                <ul class="list-group mb-2">
                    <li class="list-group-item display-7" style="background-color: rgb(50, 50, 77); color: white; font-size: 20px;">Catagories</li>
                </ul>
                <ul class="list-group">
                    <a href="#" onclick="getBlogsByUserId(<%= user.getUser_id()%>,this)" id="blog-cat"><li class="list-group-item  c-link">My blogs</li></a>
                    <a href="#"  onclick="getAllBlogs(this)" id="blog-cat"><li class="list-group-item  c-link">All blogs</li></a>
                    <a href="#"  onclick="getBlogsByTag('programming',this)" id="blog-cat"><li class="list-group-item  c-link">Programming</li></a>
                    <a href="#"  onclick="getBlogsByTag('politics',this)" id="blog-cat"><li class="list-group-item  c-link">Politics</li></a>
                    <a href="#"  onclick="getBlogsByTag('sports',this)" id="blog-cat"><li class="list-group-item  c-link">Sports</li></a>
                    <a href="#"  onclick="getBlogsByTag('entertainment',this)" id="blog-cat"><li class="list-group-item  c-link">Entertainment</li></a>
                  </ul>
            </div>

            <!-- blogs section -->
            <div class="col-md-9">
                <ul class="list-group mb-2 text-center">
                    <li class="list-group-item display-7" id="blog-section-heading" style="background-color: rgb(50, 50, 77); color: white; font-size: 20px;">All Blogs</li>
                </ul>

                <div id="loader" class="container text-center mt-5">
                    <span class="fa fa-refresh fa-spin fa-2x mb-2"></span>
                    <br>loading...
                </div>

                <div id="blog-section" class="row">
                    
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
    <script src="js/index.js"></script>



    <script>

    const getAllBlogs = (el) => {

        $("#blog-section-heading").html("All Blogs") ;
        $("#blog-section").hide() ;
        $("#loader").show() ;
        $(".c-link").removeClass('active') ;
        
        $.ajax({

                url: "get_blogs.jsp",  
                data : {
                    "get-type" : "all" 
                }, 
                success: (data, statusText , jqXHR) => {
                    $("#loader").hide() ; 
                    $("#blog-section").show() ;
                    console.log("success : "+data) ; 
                    $("#blog-section").html(data) ; 
                    $(el).children(".c-link").addClass('active')
                }, 
                error: data => {
                    $("#loader").hide() ;
                    $("#blog-section").show() ; 
                    console.log("failed : "+data) ; 
                    $("#blog-section").html(data) ; 
                    $(el).children(".c-link").addClass('active')
                }

            })


    }

    function getBlogsByTag(blogCat,el) {

            $("#loader").show() ; 
            $("#blog-section").hide() ;
            $("#blog-section-heading").html(blogCat.charAt(0).toUpperCase()+blogCat.slice(1)+" blogs")
            $(".c-link").removeClass('active') ; 
            
            $.ajax({

                url: "get_blogs.jsp" ,
                data : {
                    "blog-tag" : blogCat , 
                    "get-type" : "by-tag" 
                }, 
                success: (data, statusText , jqXHR) => {
                    $("#loader").hide() ; 
                    $("#blog-section").show() ;
                    console.log("success data  : "+data) ; 
                    $("#blog-section").html(data) ; 
                    $(el).children(".c-link").addClass('active') 
                },
                error: data => {
                    $("#loader").hide() ; 
                    $("#blog-section").show() ;
                    console.log("error data : "+data) ;
                    $("#blog-section").html(data) ;
                    $(el).children(".c-link").addClass('active') 
                }

            })
        } 


        function getBlogsByUserId(userId,el) {
            console.log(userId) ; 
            $("#loader").show() ; 
            $("#blog-section").hide() ;
            $("#blog-section-heading").html("My Blogs") ; 
            $('.c-link').removeClass('active') ;

            $.ajax({

                url: "get_blogs.jsp",  
                data : {
                    "get-type" : "by-user-id" , 
                    "user-id" : userId 
                }, 
                success: (data, statusText , jqXHR) => {
                    $("#loader").hide() ; 
                    $("#blog-section").show() ;
                    console.log("success : "+data) ; 
                    $("#blog-section").html(data) ; 
                    $(el).children(".c-link").addClass('active')
                }, 
                error: data => {
                    $("#loader").hide() ; 
                    $("#blog-section").show() ;
                    console.log("failed : "+data) ; 
                    $("#blog-section").html(data) ; 
                    $(el).children(".c-link").addClass('active')
                }

            })

        }


        $(document).ready(() => {
            
            let allPostsRef = $('[id="blog-cat"]')[1] ; 
            console.log("allPostsRef : ",allPostsRef) ; 
            getAllBlogs(allPostsRef) ;

        })

    </script>


</body>
</html>