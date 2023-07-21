<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/05981e6d7e.js" crossorigin="anonymous"></script>
    <style>
        *,
        *::after,
        *::before {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
        }

        .my-container::before {
            content: '';
            background: url("images/error_404.jpg") no-repeat center center/cover;
            height: 100%;
            width: 100%;
            position: absolute;
            top: 0;
            left: 0;
            z-index: -1;
        }

        .bg-primary-local,
        .swal-button {
            background-color: rgb(50, 50, 77);
            color: white;
        }

        .bg-primary-local:hover {
            background-color: rgba(50, 50, 77, 0.863);
            color: white;
        }
    </style>
</head>

<body>
    <div class="my-container" style="height: 100vh; width: 100vw;">


        <div class="container-fluid  text-center" style="margin-top: 55vh;">

            <a class="btn bg-primary-local" href="http://localhost:8080/TechBlog-Project/home">
                <span class="fa-solid fa-house" style="color: white;">
                </span>
                Home
            </a>

        </div>

    </div>
</body>

</html>