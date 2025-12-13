<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, java.util.HashMap, java.util.Map" %>
<%@ page import="Connection.DBConnection, jakarta.servlet.http.HttpSession" %>
<%@ page import="Services.orderServiceController" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>My Orders</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animsition.min.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style type="text/css" rel="stylesheet">
		    .indent-small {
		        margin-left: 5px;
		    }
		
		    .form-group.internal {
		        margin-bottom: 0;
		    }
		
		    .dialog-panel {
		        margin: 10px;
		    }
		
		    .datepicker-dropdown {
		        z-index: 200 !important;
		    }
		
		    .panel-body {
		        background: #e5e5e5;
		        /* Old browsers */
		        background: -moz-radial-gradient(center, ellipse cover, #e5e5e5 0%, #ffffff 100%);
		        /* FF3.6+ */
		        background: -webkit-gradient(radial, center center, 0px, center center, 100%, color-stop(0%, #e5e5e5), color-stop(100%, #ffffff));
		        /* Chrome,Safari4+ */
		        background: -webkit-radial-gradient(center, ellipse cover, #e5e5e5 0%, #ffffff 100%);
		        /* Chrome10+,Safari5.1+ */
		        background: -o-radial-gradient(center, ellipse cover, #e5e5e5 0%, #ffffff 100%);
		        /* Opera 12+ */
		        background: -ms-radial-gradient(center, ellipse cover, #e5e5e5 0%, #ffffff 100%);
		        /* IE10+ */
		        background: radial-gradient(ellipse at center, #e5e5e5 0%, #ffffff 100%);
		        /* W3C */
		        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#e5e5e5', endColorstr='#ffffff', GradientType=1);
		        font: 600 15px "Open Sans", Arial, sans-serif;
		    }
		
		    label.control-label {
		        font-weight: 600;
		        color: #777;
		    }
		
		    /* 
		table { 
			width: 750px; 
			border-collapse: collapse; 
			margin: auto;
			
			}
		
		/* Zebra striping */
		    /* tr:nth-of-type(odd) { 
			background: #eee; 
			}
		
		th { 
			background: #404040; 
			color: white; 
			font-weight: bold; 
			
			}
		
		td, th { 
			padding: 10px; 
			border: 1px solid #ccc; 
			text-align: left; 
			font-size: 14px;
			
			} */
		    @media only screen and (max-width: 760px),
		    (min-device-width: 768px) and (max-device-width: 1024px) {
		
		        /* table { 
			  	width: 100%; 
			}
		
			
			table, thead, tbody, th, td, tr { 
				display: block; 
			} */
		
		
		        /* thead tr { 
				position: absolute;
				top: -9999px;
				left: -9999px;
			}
			
			tr { border: 1px solid #ccc; } */
		
		        /* td { 
				
				border: none;
				border-bottom: 1px solid #eee; 
				position: relative;
				padding-left: 50%; 
			}
		
			td:before { 
				
				position: absolute;
			
				top: 6px;
				left: 6px;
				width: 45%; 
				padding-right: 10px; 
				white-space: nowrap;
				
				content: attr(data-column);
		
				color: #000;
				font-weight: bold;
			} */
		
		    }
    </style>
</head>

<body class="home">
    <header id="header" class="header-scroll top-header headrom">
        <nav class="navbar navbar-dark">
            <div class="container">
            	<button class="navbar-toggler hidden-lg-up" type="button" data-toggle="collapse" data-target="#mainNavbarCollapse">&#9776;</button>
                <a class="navbar-brand" href="index.jsp"> <img class="img-rounded" src="images/logo.png" alt="" width="18%"> </a>
                <div class="collapse navbar-toggleable-md  float-lg-right" id="mainNavbarCollapse">
	                <ul class="nav navbar-nav" style="">
	                    <li class="nav-item"> <a class="nav-link active" href="index.jsp">Home</a> </li>
	                    <li class="nav-item"> <a class="nav-link active" href="restaurants.jsp">Restaurants</a> </li>
	                                          
							                  
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
    
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <div class="bg-gray">
                    <div class="row">
                        <h2 class="text-center" style="margin-top:100px">My Orders</h2>
                        <table class="table table-bordered table-hover"  style="margin-top:40px; margin-bottom:40px">
                            <thead style="background: #404040; color:white;">
                                <tr>
                                    <th style="text-align:center">Item | Dish Name</th>
                                    <th style="text-align:center">Quantity</th>
                                    <th style="text-align:center">Price</th>
                                    <th style="text-align:center">Status</th>
                                    <th style="text-align:center">Date & Time</th>
                                    <th style="text-align:center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
								    try {
								        String email = (String) request.getSession().getAttribute("userEmail");
								
								        if (email != null && !email.isEmpty()) {
								            HashMap<String, HashMap<String, String>> orders = orderServiceController.showOrders(email);
								
								            if (orders.isEmpty()) {
								                out.println("<tr><td colspan='6' style='color:blue;'>No orders found.</td></tr>");
								            } 
								            else {
							
								                for (Map.Entry<String, HashMap<String, String>> entry : orders.entrySet()) {
								                    HashMap<String, String> orderDetails = entry.getValue();
								
								                    String title = orderDetails.get("title") != null ? orderDetails.get("title") : "N/A";
								                    String qty = orderDetails.get("qty") != null ? orderDetails.get("qty") : "N/A";
								                    String price = orderDetails.get("price") != null ? orderDetails.get("price") : "N/A";
								                    String status = orderDetails.get("status") != null ? orderDetails.get("status") : "N/A";
								                    String date = orderDetails.get("date") != null ? orderDetails.get("date") : "N/A";
							     %>
								                    <tr>
								                        <td data-column="Item" style="text-align:center"><%= title %></td>
								                        <td data-column="Quantity" style="text-align:center"><%= qty %></td>
								                        <td data-column="Price" style="text-align:center">$<%= price %></td>
								                        
							                        <%
							                        	if (status.equals("Processing")) {
							                        %>
								                        <td data-column="Status"  style="text-align:center"><%= status %> ⚙️</td>
								                        <td data-column="Date"  style="text-align:center"><%= date %></td>
								                        <td data-column="Action"  style="display:flex; aligh-items:center; justify-content:center">
								                            <a href="deleteOrderServletController?order_id=<%= entry.getKey() %>" 
								                               onclick="return confirm('Are you sure you want to cancel this order?');" 
								                               class="btn btn-danger btn-flat btn-addon btn-xs m-b-10">
								                               <i class="fa fa-trash-o" style="font-size:16px"></i> Cancel
								                            </a>
								                        </td>
								                    <%	
							                        	}
								                    	else if (status.equals("Dispatch")) {
								                    %>    
								                        <td data-column="Status"  style="text-align:center"><%= status %> 🚛</td>
								                        <td data-column="Date"  style="text-align:center"><%= date %></td>
								                        <td data-column="Action"  style="display:flex; aligh-items:center; justify-content:center">
								                            <a href="" 
								                               onclick="return confirm('Are you sure you want to cancel this order?');" 
								                               class="btn btn-warning btn-flat btn-addon btn-xs m-b-10" style="cursor:not-allowed;">
								                               <i class="fa fa-hourglass" style="font-size:16px"></i> Waiting ⏳
								                            </a>
								                        </td>
								                    <%
								                    	}
								                    	else if (status.equals("Delivered")) {
								                    %>    
								                        <td data-column="Status"  style="text-align:center"><%= status %> 🚩</td>
								                        <td data-column="Date"  style="text-align:center"><%= date %></td>
								                        <td data-column="Action"  style="display:flex; aligh-items:center; justify-content:center">
								                            <a href="" 
								                               onclick="return confirm('Are you sure you want to cancel this order?');" 
								                               class="btn btn-success btn-flat btn-addon btn-xs m-b-10" style="cursor:not-allowed;">
								                               <i class="fa fa-check" style="font-size:16px"></i> Thank You
								                            </a>
								                        </td>
							                        <%
								                    	}
							                        %>
								                    </tr>
							     <%
							                	}
							            	}
								        } 
								        else {
								            response.sendRedirect("login.jsp?error=Please login to view your orders.");
								        }
								    } 
								    catch (Exception e) {
								        out.println("<tr><td colspan='6' style='color:red;'>Error loading your orders. Please try again later.</td></tr>");
								        e.printStackTrace(); 
								    }
								%>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
<%@ include file="footer.jsp" %>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
