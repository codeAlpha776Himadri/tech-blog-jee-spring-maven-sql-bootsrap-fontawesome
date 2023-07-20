<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.techblog.entities.*"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles/index.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/05981e6d7e.js" crossorigin="anonymous"></script>
    <title>Tech Blog</title>

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


    <!-- banner -->


    <div class="container-fluid jumbotron  pt-5 bg-primary-local  clip-path-local">
        <div class="px-5" style="color: white;">
            <div class="row">
                <div class="col md-6">
                    <h1 class="display-3">Welcome to TechBlog</h1>
                    <p>A blog (a truncation of "weblog")[1] is an informational website published on the World Wide Web
                        consisting of discrete, often informal diary-style text entries (posts). Posts are typically
                        displayed in reverse chronological order so that the most recent post appears first, at the top
                        of the web page. Until 2009, blogs were usually the work of a single individual,[citation
                        needed] occasionally of a small group, and often covered a single subject or topic. In the
                        2010s, "multi-author blogs" (MABs) emerged</p>
                </div>
            </div>
            <a class="btn btn-outline-light mt-2 mb-5" href="login">
                <span class="fa fa-user-circle-o fa-spin" style="color: white;"></span>
                Login</a>
            <a class="btn btn-outline-light mt-2 mx-3 mb-5" href="signup">
                <span class="fa fa-user-plus" style="color: white;"></span>
                Join, Its Free...</a>
        </div>
    </div>



    <br>
    <div class="container">


        <div class="row mb-3">

            <div class="col-md-4 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Card title</h5>
                        <p class="blog-author" style="color: gray;">Himadri | <span class="blog-created-at">24th July
                                2023</span></p>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of
                            the card's content.</p>
                        <a href="#" class="btn bg-primary-local" style="color: white;">Read more...</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Card title</h5>
                        <p class="blog-author" style="color: gray;">Himadri | <span class="blog-created-at">24th July
                                2023</span></p>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of
                            the card's content.</p>
                        <a href="#" class="btn bg-primary-local" style="color: white;">Read more...</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Card title</h5>
                        <p class="blog-author" style="color: gray;">Himadri | <span class="blog-created-at">24th July
                                2023</span></p>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of
                            the card's content.</p>
                        <a href="#" class="btn bg-primary-local" style="color: white;">Read more...</a>
                    </div>
                </div>
            </div>

        </div>




        <div class="row mb-3">

            <div class="col-md-4 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Card title</h5>
                        <p class="blog-author" style="color: gray;">Himadri | <span class="blog-created-at">24th July
                                2023</span></p>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of
                            the card's content.</p>
                        <a href="#" class="btn bg-primary-local" style="color: white;">Read more...</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Card title</h5>
                        <p class="blog-author" style="color: gray;">Himadri | <span class="blog-created-at">24th July
                                2023</span></p>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of
                            the card's content.</p>
                        <a href="#" class="btn bg-primary-local" style="color: white;">Read more...</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Card title</h5>
                        <p class="blog-author" style="color: gray;">Himadri | <span class="blog-created-at">24th July
                                2023</span></p>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of
                            the card's content.</p>
                        <a href="#" class="btn bg-primary-local" style="color: white;">Read more...</a>
                    </div>
                </div>
            </div>

        </div>




    </div>



    <!-- footer  -->

    <%@include file="footer.jsp"%>





    <script src="https://code.jquery.com/jquery-3.7.0.min.js"
        integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
    <script src="js/index.js"></script>




</body>

</html>