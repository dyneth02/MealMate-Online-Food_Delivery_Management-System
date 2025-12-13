<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement,jakarta.servlet.http.HttpSession" %>
<%@ page import="Connection.DBConnection, Services.restaurantServiceController, java.util.HashMap, java.util.Map" %>

<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="#">
    <title>Restaurants</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animsition.min.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
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
                        
                        <% 
						    String is_done = null;
						    HttpSession sessionHome = request.getSession(false); // Use false to avoid creating a new session
						
						    if (sessionHome != null) { // If session exists
						        is_done = (String) sessionHome.getAttribute("login_status");
						
						        if (is_done == null || !is_done.equals("true")) {  // Check if user is not logged in
						%>
						            <li class="nav-item"><a href="login.jsp" class="nav-link active">Login</a></li>
						            <li class="nav-item"><a href="registration.jsp" class="nav-link active">Register</a></li>
						<% 
						        } else {  // User is logged in
						%>
						            <li class="nav-item"><a href="your_orders.jsp" class="nav-link active">My Orders</a></li>
						            <li class="nav-item"><a href="signoutServletController" class="nav-link active">Logout</a></li>
						            <li class="nav-item"><a href="updateAcc.jsp" class="nav-link active"><img src="images/Avatar.png" style="height:30px; width:30px;"></a></li>
						<% 
						        }
						    } 
						%>
                        
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <div class="page-wrapper">
        <div class="top-links">
            <div class="container">
                <ul class="row links">

                    <li class="col-xs-12 col-sm-4 link-item active"><span>1</span><a href="#">Choose Restaurant</a></li>
                    <li class="col-xs-12 col-sm-4 link-item"><span>2</span><a href="#">Pick Your favorite food</a></li>
                    <li class="col-xs-12 col-sm-4 link-item"><span>3</span><a href="#">Order and Pay</a></li>
                </ul>
            </div>
        </div>
        <div class="inner-page-hero bg-image" data-image-src="images/img/pimg.jpg">
            <div class="container"> </div>
        </div>
        <div class="result-show">
            <div class="container">
                <div class="row">
                </div>
            </div>
        </div>
        <section class="restaurants-page">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-md-5 col-lg-3">
                    </div>
                    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-9">
                        <div class="bg-gray restaurant-entry">
                            <div class="row">
                                <%
	                                HashMap<String, HashMap<String, String>> restaurants = restaurantServiceController.showRestaurant();
	                                if (restaurants != null && !restaurants.isEmpty()) {
	                                    for (Map.Entry<String, HashMap<String, String>> entry : restaurants.entrySet()) {
	                                        String rest_id = entry.getKey();
	                                        HashMap<String, String> restDetails = entry.getValue();
						        %>
									        <div class="col-sm-12 col-md-12 col-lg-8 text-xs-center text-sm-left">
									            <div class="entry-logo">
									                <a class="img-fluid" href="dishes.jsp?res_id=<%= rest_id %>">
									                    <img src="admin/Res_img/<%= restDetails.get("rimage") %>" alt="Food logo">
									                </a>
									            </div>
									            <div class="entry-dscr">
									                <h5>
									                    <a href="dishes.jsp?res_id=<%= rest_id %>">
									                        <%= restDetails.get("rtitle") %>
									                    </a>
									                </h5>
									                <span><%= restDetails.get("raddress") %></span>
									            </div>
									        </div>
									
									        <div class="col-sm-12 col-md-12 col-lg-4 text-xs-center">
									            <div class="right-content bg-white">
									                <div class="right-review">
									                    <a href="dishes.jsp?res_id=<%= rest_id %>" class="btn btn-purple">View Menu</a>
									                </div>
									            </div>
									        </div>
						        <%
	                                    }
	                                }
                                    else {
						        %>
						        			<div class="col-sm-12 col-md-12 col-lg-4 text-xs-center">
									            <div class="right-content bg-white">
									                <p>No restaurants to be displayed</p>
									            </div>
									        </div>
						        <%
                                    }
						        %>

                            </div>

                        </div>



                    </div>
                </div>
            </div>
    </div>
    </section>
    <script src="js/jquery.min.js"></script>
    <script src="js/tether.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/animsition.min.js"></script>
    <script src="js/bootstrap-slider.min.js"></script>
    <script src="js/jquery.isotope.min.js"></script>
    <script src="js/headroom.js"></script>
    <script src="js/foodpicky.min.js"></script>
</body>
</html>