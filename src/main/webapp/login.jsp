<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement" %>
<%@ page import="Connection.DBConnection" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Login || Code Camp BD</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    <link rel='stylesheet prefetch' href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900|RobotoDraft:400,100,300,500,700,900'>
    <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>
    <link rel="stylesheet" href="css/login.css">

    <style type="text/css">
    #buttn {
        color: #fff;
        background-color: #5c4ac7;
    }
    </style>

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animsition.min.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    
    <!-- Import the JavaScript module -->
    <script type="module" src="path/to/your/module.js"></script>

</head>
<body>
    <header id="header" class="header-scroll top-header headrom">
        <nav class="navbar navbar-dark">
            <div class="container">
                <button class="navbar-toggler hidden-lg-up" type="button" data-toggle="collapse" data-target="#mainNavbarCollapse">&#9776;</button>
                <a class="navbar-brand" href="index.jsp"> <img class="img-rounded" src="images/logo.png" alt="" width="18%"> </a>
                <div class="collapse navbar-toggleable-md  float-lg-right" id="mainNavbarCollapse">
                    <ul class="nav navbar-nav">
                        <li class="nav-item"> <a class="nav-link active" href="index.jsp">Home <span class="sr-only">(current)</span></a> </li>
                        <li class="nav-item"> <a class="nav-link active" href="restaurants.jsp">Restaurants <span class="sr-only"></span></a> </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <div style="background-image: url('images/img/pimg.jpg');">
        <div class="pen-title"></div>

        <div class="module form-module">
            <div class="toggle"></div>
            <div class="form">
                <h2>Login to your account</h2>

                <!-- Show error message if login fails -->
                <%
                    String loginError = (String) request.getAttribute("login_error");
                    if (loginError != null) {
                %>
                    <div id="error-message" style="color:red;"><%= loginError %></div>
                    <script>
                        import { handleLoginError } from './moduleLogin.js';
                        handleLoginError();
                    </script>
                <%
                    }
                %>

                <form action="loginServletController" method="POST">
                    <input type="text" placeholder="Email" name="vemail" />
                    <input type="password" placeholder="Password" name="vpassword" />
                    <input type="submit" id="buttn" name="submit" value="Login" />
                </form>
            </div>

            <div class="cta">Not registered? <a href="registration.jsp" style="color:#5c4ac7;"> Create an account</a></div>
        </div>

        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <div class="container-fluid pt-3"><p></p></div>
    </div>
<%@ include file="footer.jsp" %>
</body>
</html>
