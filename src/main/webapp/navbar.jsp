<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.techblog.entities.*" %>

<%!
    String username ;  
%>

<%
    if (session.getAttribute("user") != null) {
        User user = (User) session.getAttribute("user") ;
        username = user.getUser_name() ; 
    }
    else {
        username = "Profile" ;
    }
%>


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
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                        aria-expanded="false">
                        <span class="fa fa-check-square-o" style="color: white;"></span>
                        Catagories
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Technology</a></li>
                        <li><a class="dropdown-item" href="#">Entertainment</a></li>
                        <li><a class="dropdown-item" href="#">Programming</a></li>
                    </ul>
                </li>
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
                <li class="nav-item">
                    <a class="nav-link" href="Logout"> <span class="fa fa-user-times" style="color: white;"></span>
                        Logout</a>
                </li>
            </ul>
            <form action="#" method="POST" class="d-flex" role="search">
                <input class="form-control me-2" type="search" name="search-text" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-light" type="submit">Search</button>
            </form>

            <ul class="navbar-nav mb-2 mb-lg-0 ml-4">
                <li class="nav-item" style="cursor: pointer;">
                    <a class="nav-link" href="profile">
                        <span class="fa fa-user" style="color: white;"></span>
                            <%= username%>
                        </a>
                </li>
            </ul>
        </div>
    </div>
</nav>