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
    <title>Dishes || Online Food Ordering System - Code Camp BD</title>
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
                        
                        
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <div class="page-wrapper">
        <div class="top-links">
            <div class="container">
                <ul class="row links">

                    <li class="col-xs-12 col-sm-4 link-item"><span>1</span><a href="restaurants.jsp">Choose Restaurant</a></li>
                    <li class="col-xs-12 col-sm-4 link-item active"><span>2</span><a href="dishes.jsp?res_id=1">Pick Your favorite food</a></li>
                    <li class="col-xs-12 col-sm-4 link-item"><span>3</span><a href="#">Order and Pay</a></li>

                </ul>
            </div>
        </div>
        <%
		    String resId = request.getParameter("res_id");
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    String title = "", address = "", image = ""; 
		
		    try {
		        conn = DBConnection.getConnection(); 
		        String sql = "SELECT * FROM restaurant WHERE rs_id = ?";
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setString(1, resId); 
		        
		        rs = pstmt.executeQuery(); 
		        
		        if (rs.next()) {
		            title = rs.getString("title");
		            address = rs.getString("address");
		            image = rs.getString("image");
		        } else {
		            out.println("<p>No restaurant found for the given ID.</p>");
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		        out.println("<p>An error occurred while accessing the database.</p>");
		    }
		%>
        <section class="inner-page-hero bg-image" data-image-src="images/img/restrrr.png">
            <div class="profile">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12  col-md-4 col-lg-4 profile-img">
                            <div class="image-wrap">
                                <figure><img src="admin/Res_img/<%= image %>" alt="Restaurant logo"></figure>
                            </div>
                        </div>

                        <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8 profile-desc">
                            <div class="pull-left right-text white-txt">
                                <h6><a href="#"><%= title %></a></h6>
                                <p><%= address %></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div class="breadcrumb">
            <div class="container">
                
            </div>
        </div>
        <div class="container m-t-30">
            <div class="row">
            
            	<!-- dishes' gallery start -->
                <div class="col-md-8">


                    <div class="menu-widget" id="2">
                        <div class="widget-heading">
                            <h3 class="widget-title text-dark">
                                MENU <a class="btn btn-link pull-right" data-toggle="collapse" href="#popular2" aria-expanded="true">
                                    <i class="fa fa-angle-right pull-right"></i>
                                    <i class="fa fa-angle-down pull-right"></i>
                                </a>
                            </h3>
                            <div class="clearfix"></div>
                        </div>
                        <div class="collapse in" id="popular2">
                        	<%                      		 
	                        	HashMap<String, HashMap<String, String>> dishes = dishServiceController.showDishes(resId);
	                            if (dishes != null && !dishes.isEmpty()) {
	                                for (Map.Entry<String, HashMap<String, String>> entry : dishes.entrySet()) {
	                                    String dish_id = entry.getKey();
	                                    HashMap<String, String> dishDetails = entry.getValue();
                        	%>
			                            <div class="food-item">
			                                <div class="row">
			                                	<form method="POST" action="addDishesServletController" onsubmit="validateQuantity(event)">
												    <input type="hidden" name="res_id" value="<%= resId %>" />
												    <input type="hidden" name="id" value="<%= dish_id %>" />   
												    <input type="hidden" name="price" value="<%= dishDetails.get("dprice") %>" />
												    <input type="hidden" name="title" value="<%= dishDetails.get("dtitle") %>" /> 
												    <input type="hidden" name="action" value="add" /> 
												
												    <div class="col-xs-12 col-sm-12 col-lg-8">
												        <div class="rest-logo pull-left">
												            <a class="restaurant-logo pull-left" href="#"><img src="admin/Res_img/dishes/<%= dishDetails.get("dimage") %>" alt="Food logo"></a>
												        </div>
												
												        <div class="rest-descr">
												            <h6><a href="#"><%= dishDetails.get("dtitle") %></a></h6>
												            <p><%= dishDetails.get("dslogan") %></p>
												        </div>
												    </div>
												
												    <div class="col-xs-12 col-sm-12 col-lg-3 pull-right item-cart-info">
												        <span class="price pull-left">$<%= dishDetails.get("dprice") %></span>
												        <input class="b-r-0" type="text" name="quantity" id="quantity" style="margin-left:30px;" value="1" size="2" />
												        <input type="submit" onclick="validateQuantity(event)" class="btn theme-btn" style="margin-left:40px;" value="Add To Cart" />
												    </div>
												</form>

			                                </div>		
			                            </div>
                        	<%
	                                }                        			
	                            }
	                            else { 
                            %>
	                            <div>No dishes available.</div>
                            <% 
                            	} 
                           	%>
                        	
                            
                        </div>
                    </div>
                </div>
                <!-- dishes' gallery end -->
            	
            
            	<!-- cart checkout start -->
                <div class="col-xs-12 col-sm-4 col-md-4 col-lg-3">
				    <div class="order-row bg-white">
				        <div class="widget-body">
				            <%
				                if (session.getAttribute("cart") == null) {
				                    session.setAttribute("cart", new ArrayList<HashMap<String, String>>());
				                }
				                
				                List<HashMap<String, String>> cart = (List<HashMap<String, String>>) session.getAttribute("cart");
				                
				                String keyToCheck = "action";
				                if ("add".equals(request.getParameter(keyToCheck))) {
				                    String did = request.getParameter("id");
				                    String dprice = request.getParameter("price");
				                    String dtitle = request.getParameter("title");
				                    String dqty = request.getParameter("quantity");
				
				                    HashMap<String, String> newItem = new HashMap<>();
				                    newItem.put("id", did);
				                    newItem.put("title", dtitle);
				                    newItem.put("price", dprice);
				                    newItem.put("quantity", dqty);
		
				                    cart.add(newItem);
				                    session.setAttribute("cart", cart); 
				                }
				                
				                else if ("remove".equals(request.getParameter(keyToCheck))) {
				                    String did = request.getParameter("id");
				                 
				                    for (Iterator<HashMap<String, String>> iterator = cart.iterator(); iterator.hasNext();) {
				                        HashMap<String, String> item = iterator.next();
				                        if (item.get("id").equals(did)) {
				                            iterator.remove(); 
				                            break;
				                        }
				                    }
				                    session.setAttribute("cart", cart); 
				                }
				            %>
				
				            <div class="widget widget-cart">
				                <div class="widget-heading">
				                    <h3 class="widget-title text-dark">
				                        Your Cart
				                    </h3>
				                    <div class="clearfix"></div>
				                </div>
				
				                <div class="order-row bg-white">
				                    <div class="widget-body">
				                        <%
				                            double totalPrice = 0.0;
				
				                            if (!cart.isEmpty()) {
				                                for (HashMap<String, String> item : cart) {
				                                    String id = item.get("id");
				                                    String ctitle = item.get("title");
				                                    String price = item.get("price");
				                                    String quantity = item.get("quantity");
				
				                                    double itemTotal = Double.parseDouble(price) * Integer.parseInt(quantity);
				                                    totalPrice += itemTotal;
				                        %>
				                                    <div class="title-row">
				                                        <%= ctitle %>
				                                        <a href="dishes.jsp?res_id=<%= resId %>&action=remove&id=<%= id %>"><i class="fa fa-trash pull-right"></i></a>
				                                    </div>
				
				                                    <div class="form-group row no-gutter">
				                                        <div class="col-xs-8">
				                                            <input type="text" class="form-control b-r-0" value="$<%= price %>" readonly id="exampleSelect1">
				                                        </div>
				                                        <div class="col-xs-4">
				                                            <input class="form-control" type="text" readonly value="<%= quantity %>" id="example-number-input">
				                                        </div>
				                                    </div>
				                        <%
				                                }
				                            } else {
				                                out.println("<p>Your cart is empty.</p>");
				                            }
				                        %>
				                    </div>
				                </div>
				
				                <div class="widget-body">
				                    <div class="price-wrap text-xs-center">
				                        <p>TOTAL</p>
				                        <h3 class="value"><strong>$<%= totalPrice %></strong></h3>
				                        <p>Free Delivery!</p>
				
				                        <%	
				                            // Conditionally enable checkout button if the cart is not empty
				                            if (!cart.isEmpty()) {
				                        %>
				                            <a href="checkout.jsp?res_id=<%= resId %>&action=check&tot=<%= totalPrice %>" class="btn btn-success btn-lg active">Checkout</a>
				                        <%
				                            } else {
				                        %>
				                            <a href="#" class="btn btn-danger btn-lg disabled">Checkout</a>
				                        <%
				                            }
				                        %>
				                    </div>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>

                <!-- cart checkout end -->
                

            </div>

        </div>

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
    
    
    <script>
	    function validateQuantity(event) {
	        var quantityField = document.getElementById("quantity");
	        var quantity = quantityField.value.trim(); 
	
	        if (quantity === "") {
	            alert("Quantity field cannot be empty.");
	            quantityField.value = "";
	            event.preventDefault();
	            return false;
	        }
	
	        if (isNaN(quantity) || quantity <= 0) {
	            alert("Please enter a valid quantity (greater than zero).");
	            quantityField.value = "";
	            event.preventDefault();  
	            return false;
	        }
	        
	        if (quantity > 10) {
	            alert("The maximum order limit is 10.");
	            quantityField.value = "";
	            event.preventDefault();  
	            return false;
	        }
	
	        return true;  
	    }
    </script>
</body>

</html>