<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement,java.sql.PreparedStatement, jakarta.servlet.http.HttpSession, Services.dishServiceController, java.util.ArrayList, java.util.List" %>
<%@ page import="Connection.DBConnection, Services.restaurantServiceController, java.util.HashMap, java.util.Map, jakarta.servlet.ServletException, jakarta.servlet.http.HttpServlet, jakarta.servlet.http.HttpServletRequest, java.io.IOException, java.util.Iterator" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="#">
    <title>Checkout || Online Food Ordering System - Code Camp BD</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animsition.min.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
    <div class="site-wrapper">
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
						    HttpSession sessionDishes = request.getSession(false); // Use false to avoid creating a new session
						
							    if (sessionDishes != null) { // If session exists
							        is_done = (String) sessionDishes.getAttribute("login_status");
							
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
                    </div>
                </div>
            </nav>
        </header>
        <div class="page-wrapper">
            <div class="top-links">
                <div class="container">
                    <ul class="row links">

                        <li class="col-xs-12 col-sm-4 link-item"><span>1</span><a href="restaurants.jsp">Choose Restaurant</a></li>
                        <li class="col-xs-12 col-sm-4 link-item "><span>2</span><a href="#">Pick Your favorite food</a></li>
                        <li class="col-xs-12 col-sm-4 link-item active"><span>3</span><a href="checkout.jsp">Order and Pay</a></li>
                    </ul>
                </div>
            </div>

            <div class="container">

                <span style="color:green;">
                </span>

            </div>
            
            
			<%
			    String tot = request.getParameter("tot");
			    if (tot != null) {
			        Double total = Double.parseDouble(tot);
			    } else {
			        out.println("<p>Total value not provided.</p>");
			    }
			%>
			
			
            <div class="container m-t-30">
                <form action="" method="post">
                    <div class="widget clearfix">

                        <div class="widget-body">
                            <form method="post" action="#">
                                <div class="row">

                                    <div class="col-sm-12">
                                        <div class="cart-totals margin-b-20">
                                            <div class="cart-totals-title">
                                                <h4>Cart Summary</h4>
                                            </div>
                                            <div class="cart-totals-fields">

                                                <table class="table">
                                                    <tbody>

                                                        <tr>
                                                            <td>Cart Subtotal</td>
                                                            <td>$<%= tot %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Delivery Charges</td>
                                                            <td>Free</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="text-color"><strong>Total</strong></td>
                                                            <td class="text-color"><strong>$<%= tot %></strong></td>
                                                        </tr>
                                                    </tbody>


                                                </table>
                                            </div>
                                        </div>
                                        <div class="payment-option">
                                            <ul class=" list-unstyled">
                                                <li>
                                                    <label class="custom-control custom-radio  m-b-20">
                                                        <input name="mod" id="radioStacked1" checked value="COD" type="radio" class="custom-control-input"> <span class="custom-control-indicator"></span> <span class="custom-control-description">Cash on Delivery</span>
                                                    </label>
                                                </li>
                                                <li>
                                                    <label class="custom-control custom-radio  m-b-10">
                                                        <input name="mod" type="radio" value="paypal" disabled class="custom-control-input"> <span class="custom-control-indicator"></span> <span class="custom-control-description">Paypal <img src="images/paypal.jpg" alt="" width="90"></span> </label>
                                                </li>
                                            </ul>
                                            
                                        </div>
                            		</form>
                        </div>
                    </div>
				    <div style="max-width:200px; display:flex; justify-content:center; align-items:center; position:absolute; top:240px; right:310px">
				    	<p class="text-xs-center">
						    <form id="orderForm" method="POST" action="orderNowServletController">
						        <input type="submit" onclick="return confirmOrder();" name="submit" class="btn btn-success btn-block" value="Order Now">
						    </form>
						</p>
						
						<script>
						    function confirmOrder() {
						        // Confirm the order
						        if (confirm('Do you want to confirm the order?')) {
						            // If confirmed, return true to submit the form
						            return true;
						        } else {
						            // If not confirmed, prevent form submission
						            return false;
						        }
						    }
						</script>
				    	
				   </div>

            </div>
        </div>
    </div>
    
<%@ include file="footer.jsp" %>
    </div>
    </div>

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
