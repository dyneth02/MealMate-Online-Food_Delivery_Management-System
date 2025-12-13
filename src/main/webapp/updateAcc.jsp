<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement,jakarta.servlet.http.HttpSession" %>
<%@ page import="Connection.DBConnection, Services.userServiceController, java.util.HashMap" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="#">
    <title>Update Your Account</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animsition.min.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
	<div style="background-image: url('images/img/pimg.jpg');">
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
							    HttpSession sessionHome = request.getSession(false); 
							
							    if (sessionHome != null) { // If session exists
							        is_done = (String) sessionHome.getAttribute("login_status");
							
							        if (is_done == null || !is_done.equals("true")) { 
							%>
							            <li class="nav-item"><a href="login.jsp" class="nav-link active">Login</a></li>
							            <li class="nav-item"><a href="registration.jsp" class="nav-link active">Register</a></li>
							            
							<% 
							        } else {
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

            <div class="container">
                
            </div>
            <section class="contact-page inner-page">
                <div class="container ">
                    <div class="row ">
                        <div class="col-md-12">
                            <div class="widget">
                                <div class="widget-body">
                                    <form action="updateUserServletController" method="POST">
                                    	<div class="form-group col-sm-6" id="error-message" style="font-weight:400; color:red; display:none;"></div>
                                    	<div class="form-group col-sm-6" id="error-message2" style="font-weight:400; color:red; display:none;"></div>
                                        <div class="row">
                                        	<%
                                        	
                                        	String mymail = (String) sessionHome.getAttribute("userEmail");
                                       		HashMap<String, String> user = userServiceController.showUser(mymail);
                                        	
                                       		String username = user.get("uname");
                                       		String password = user.get("password");
                                       		String contact = user.get("phone");
                                       		String address = user.get("address");
                                        	
                                        	%>
                                            <div class="form-group col-sm-12">
                                                <label for="exampleInputEmail1">User-Name</label>
                                                <input class="form-control" type="text" name="username" id="example-text-input" placeholder="<%= username %>">
                                            </div>
                                            <div class="form-group col-sm-6">
                                                <label for="exampleInputEmail1">Email Address</label>
                                                <input type="text" class="form-control" name="email" value="<%= mymail %> - The Email cannot be changed" id="exampleInputEmail1" aria-describedby="emailHelp" style="color:red" disabled>
                                            </div>
                                            <div class="form-group col-sm-6">
                                                <label for="exampleInputEmail1">Phone number</label>
                                                <input class="form-control" type="text" name="phone" id="phone"  placeholder="<%= contact %>">
                                            </div>
                                            <div class="form-group col-sm-6">
                                                <label for="exampleInputPassword1">Password</label>
                                                <input type="password" class="form-control" name="password" id="password"  placeholder="<%= password %>">
                                            </div>
                                            <div class="form-group col-sm-6">
                                                <label for="exampleInputPassword1">Confirm password</label>
                                                <input type="password" class="form-control" name="cpassword" id="cpassword">
                                            </div>
                                            <div class="form-group col-sm-12">
                                                <label for="exampleTextarea">Delivery Address</label>
                                                <textarea class="form-control" id="exampleTextarea" name="address" rows="3" placeholder="<%= address %>"></textarea>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="form-group col-sm-4">
                                                <a href="updateUserServletController"><input type="submit" value="Update" onclick="onSubmitButtonClick(event)" name="submit" class="btn theme-btn"></a>
                                            </div>
                                        </div>
                                    </form>

                                </div>

                            </div>

                        </div>

                    </div>
                </div>
            </section>

        </div>
		<%@ include file="footer.jsp" %>

        <script src="js/jquery.min.js"></script>
        <script src="js/tether.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/animsition.min.js"></script>
        <script src="js/bootstrap-slider.min.js"></script>
        <script src="js/jquery.isotope.min.js"></script>
        <script src="js/headroom.js"></script>
        <script src="js/foodpicky.min.js"></script>
        
        <!-- JavaScript for Validation -->
		<script>
		    function validatePasswords() {
		        var passwordField = document.getElementById("password");
		        var confirmPasswordField = document.getElementById("cpassword");
		        var errorMessage = document.getElementById("error-message");
		
		        var password = passwordField.value;
		        var confirmPassword = confirmPasswordField.value;
		
		        if (password !== confirmPassword) {
		            errorMessage.style.display = "block";
		            errorMessage.style.color = "red"; 
		            errorMessage.innerText = "Passwords do not match!";
		            return false; 
		        } else {
		            errorMessage.style.display = "none";
		            return true; 
		        }
		    }
		
		    function onSubmitButtonClick(event) {
		        if (!validatePasswords()) {
		            event.preventDefault();
		        }
		    }
		    
		    function validateTel() {
		        var phoneField = document.getElementById("phone");
		        var errorMessage = document.getElementById("error-message2");
		        
		        var phone = phoneField.value; 
		        
		        if (phone.length !== 10 || isNaN(phone)) { 
		            errorMessage.style.display = "block";
		            errorMessage.style.color = "red"; 
		            errorMessage.innerText = "Phone number is Invalid!";
		            return false; 
		        } else {
		            errorMessage.style.display = "none";  
		            return true;  
		        }
		    }

		</script>
</body>

</html>