<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
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
        </style>
    </head>

    <body>

        <!-- navbar -->

        <%@include file="navbar.jsp" %>



            <%-- login form control --%>

                <div class="container-fluid bg-primary-local">


                    <div class="row">


                        <div class="col-md-4 offset-4 bg-primary-local" style="color: white;">

                            <form id="login-form" action="Login" method="post">

                                <div style="height: 102px;"></div>

                                <h4 class="text-center mt-3">
                                    <div class="header">Login <span class="fa fa-user"></span></div>
                                </h4>
                                <div class="mb-3">
                                    <label for="formGroupExampleInput2" class="form-label">Email: </label>
                                    <input name="user_email" required type="email" class="form-control"
                                        id="user_email" placeholder="Enter email...">
                                </div>
                                <div class="mb-3">
                                    <label for="formGroupExampleInput2" class="form-label">Password: </label>
                                    <input name="user_password" required type="password" class="form-control"
                                        id="user_password" placeholder="Enter password...">
                                </div>


                                <div class="text-center" id="loader" style="font-size: 28px; display: none;">
                                    <span class="fa fa-circle-o-notch fa-spin"></span>
                                </div>

                                <div class="text-center" id="loader" style="font-size: 28px; display: none; margin-top: 14px;">
                                    <span class="fa fa-circle-o-notch fa-spin"></span>
                                </div>

                                <div class="text-center">
                                    <button id="login-btn" type="submit" class="btn mt-4 mb-5"
                                        style="background-color: white; color: rgb(50, 50, 77);">Login <span
                                            class="fa fa-user"></span></button>
                                </div>

                                <div class="space" style="height: 140px;"></div>
                            </form>

                        </div>


                    </div>


                </div>





                <!-- footer -->

                <%@include file="footer.jsp" %>



                    <script src="https://code.jquery.com/jquery-3.7.0.min.js"
                        integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
                        crossorigin="anonymous"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
                        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
                        crossorigin="anonymous"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        


        <!-- jquery  -->
        <script>

            $(document).ready(() => {

                console.log("jquery active...") ;


                $("#login-form").submit(e => {

                    $("#login-btn").hide() ; 
                    $("#loader").show() ;

                    e.preventDefault() ; 

                    // console.log($("#user_email").val()," , ",$("#user_password").val())

                    
                    $.ajax({

                        url: "Login" , 
                        data: {
                            user_email: $("#user_email").val() , 
                            user_password: $("#user_password").val() 
                        },
                        type: "POST" ,
                        timeout: 50000 ,
                        success: (data,textStatus,jqXHR) => {

                            $("#login-btn").show() ; 
                            $("#loader").hide() ;
                            console.log("success: "+data) ;

                            // swal(data)
                            // .then((value) => {
                            //     if (data == "login success...") {
                            //         window.location.href="profile" ;
                            //     } 
                            // }); 

                            if (data == "login success...") {
                                swal("Welcome","Redirecting to profile page!","success")
                                .then(val => {
                                window.location.href="profile" ;
                                })
                            }
                            else {
                                swal("Error!",data,"warning") ;
                            }

                        }, 
                        error: (data,textStatus,jqXHR) => {

                            $("#login-btn").show() ; 
                            $("#loader").hide() ;
                            console.log("failed: "+data) ;

                            swal("Error submitting the form...","warning") ; 


                        }

                    })

                })

            })


        </script>


    </body>

    </html>