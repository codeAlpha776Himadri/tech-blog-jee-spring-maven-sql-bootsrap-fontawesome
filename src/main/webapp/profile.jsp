<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.techblog.entities.*" %>

<%!
    User user; 
%>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login") ; 
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
    <title>Contact Us</title>
    <link rel="stylesheet" href="styles/index.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/05981e6d7e.js" crossorigin="anonymous"></script>
    

    <style>
        .bg-primary-local {
            background-color: rgb(50, 50, 77);
            /* color: red; */
        }
    </style>
</head>
<body>
    
    <!-- navbar -->

     <%@include file="navbar.jsp"%>



    <%-- profile content --%>

    Hello i am profile page
    <br>
    <hr>
    <h3><%= user%></h3>
    <hr>


      
     
    <!-- footer -->

    <%@include file="footer.jsp"%>




    <script src="https://code.jquery.com/jquery-3.7.0.min.js"
        integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
    <script src="js/index.js"></script>

</body>
</html>