<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup</title>
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

     <%@include file="navbar.jsp"%>

      

    <%-- signup form control --%>

    <div class="container-fluid bg-primary-local">

        <div class="row">

            <div class="col-md-4 offset-4 bg-primary-local" style="color: white;">
                <form id="signup-form" action="Register" method="post">
                      <div style="height: 28px"></div>
                      <h4 class="text-center mt-3">
                        <div class="header">Register <span class="fa fa-user"></span></div>
                      </h4>
                      <div class="mb-3">
                        <label for="formGroupExampleInput" class="form-label">Username: </label>
                        <input name="user_name" required type="text" class="form-control" id="user_name" placeholder="Enter name...">
                      </div>
                      <div class="mb-3">
                        <label for="formGroupExampleInput2" class="form-label">Email: </label>
                        <input name="user_email" required type="email" class="form-control" id="user_email" placeholder="Enter email...">
                      </div>
                      <div class="mb-3">
                        <label for="formGroupExampleInput2" class="form-label">Password: </label>
                        <input name="user_password" required type="password" class="form-control" id="user_password" placeholder="Enter password...">
                      </div>
                      <div class="mb-3">
                        <label for="form-check form-check-inline" class="form-label">Gender: </label>
                        <br>
                          <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="user_gender" id="user_gender" value="male" checked>
                            <label class="form-check-label" for="inlineRadio1">Male</label>
                          </div>
                          <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="user_gender" id="user_gender" value="female">
                            <label class="form-check-label" for="inlineRadio2">Female</label>
                          </div>
                      </div>
                      <div class="mb-3 mt-4">
                        <div class="form-check">
                            <input required class="form-check-input" type="checkbox" name="terms_check" value="checked" id="user_terms_check" >
                            <label class="form-check-label" for="flexCheckChecked">
                              Terms and Conditions
                            </label>
                          </div>
                      </div>

                      <div class="text-center" id="loader" style="font-size: 28px; display: none;">
                        <span class="fa fa-circle-o-notch fa-spin"></span>
                      </div>

                      <div class="text-center">
                        <button id="signup-btn" type="submit" class="btn mb-5" style="background-color: white; color: rgb(50, 50, 77);">Register <span class="fa fa-user"></span></button>
                      </div>

                      <div style="height: 30px;"></div>
                </form>
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





    <!-- <%-- jquery  --%> -->

    <script>

      $(document).ready(() => {


        $("#signup-form").submit(e => {

          e.preventDefault() ;

          $("#signup-btn").hide() ; 
          $("#loader").show() ;

          let form_data = {
            user_name : $("#user_name").val() , 
            user_email : $("#user_email").val() , 
            user_password : $("#user_password").val() , 
            user_gender : $("input[name='user_gender']:checked").val() , 
            terms_check : $("#user_terms_check").val() 
          }

          $.ajax({

            url: "Register" , 
            type: "POST" , 
            data : form_data ,
            success: (data, textStatus, jqXHR) => {

              // console.log(form_data) ;
              $("#signup-btn").show() ; 
              $("#loader").hide() ;

              // debug
              // console.log({"data" : data ,"textStatus" : textStatus, "jqXHR": jqXHR}) ; 


              if (data == "Registration success, Please login...") {
                swal("Welcome to TechBlog","Redirecting to profile page!","success")
                .then(val => {
                  window.location.href="profile" ;
                })
              }
              else {
                swal("Error!",data,"warning") ;
              }

            }, 
            error: (data, textStatus, jqXHR) => {

              console.log(form_data) ;
              $("#signup-btn").show() ; 
              $("#loader").hide() ;

              swal("Oh! No!!!","Error submitting the form...","warning") ;

            }
            
          })



        })



      })


    </script>


</body>
</html>