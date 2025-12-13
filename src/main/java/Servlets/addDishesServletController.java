package Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import Models.cartItemModel;
import Services.dishServiceController;

public class addDishesServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String uemail = (String) request.getSession().getAttribute("userEmail");
    	String title = request.getParameter("title");
    	
		String rid_str = request.getParameter("res_id");
    	String did_str = request.getParameter("id");
    	String uprice_str = request.getParameter("price");
    	String qty_str = request.getParameter("quantity");
    	
    	try {
			Integer rid = Integer.parseInt(rid_str);
			Integer did = Integer.parseInt(did_str);
			Double uprice = Double.parseDouble(uprice_str);
			Integer qty = Integer.parseInt(qty_str);
			
			Double tprice = uprice * qty;
   
			cartItemModel addedDish = new cartItemModel(did, rid, uemail, title, uprice, qty, tprice);
			
			if (dishServiceController.addDishesToCart(addedDish)) {
				RequestDispatcher dis = request.getRequestDispatcher("dishes.jsp?res_id="+rid_str);
				dis.forward(request, response);
			}
		} 
    	catch (NumberFormatException e) {
			System.out.println("Parsing awlak " + e);
		} 
    	catch (ClassNotFoundException e) {
    		System.out.println("Class nathi awlak " + e);
		} 
    	catch (SQLException e) {
    		System.out.println("SQL awlak " + e);
		}
    	
    	
	}

}
