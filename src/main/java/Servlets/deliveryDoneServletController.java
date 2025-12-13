package Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import Connection.DBConnection;
import Services.walletServiceController;

public class deliveryDoneServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uemail = request.getParameter("email");
		String semail = (String) request.getSession().getAttribute("semail");
		
		try (Connection con = DBConnection.getConnection()) {
			String sql_update = "UPDATE users_orders SET status = 'Delivered' WHERE u_email = ?";
			PreparedStatement stmt = con.prepareStatement(sql_update);
			stmt.setString(1, uemail);
			
			System.out.println(stmt);
			int done = stmt.executeUpdate();
			
			try {
			    HashMap<String, String> wdetails = walletServiceController.getWalletDetails(semail);
			    String sessionamt = wdetails.get("amt");
			    System.out.println(sessionamt);
			    Double wamt = Double.parseDouble(sessionamt);
			    
			    wamt += 20.00;

			    String sql_increase = "UPDATE wallet SET amount = ? WHERE s_email = ?";
			    PreparedStatement ps = con.prepareStatement(sql_increase);
			    
			    ps.setDouble(1, wamt);
			    ps.setString(2, semail);

			    System.out.println(ps);
			    
			    int increased = ps.executeUpdate();

			    if (increased > 0) {
			        System.out.println("Wallet amount updated successfully.");
			    } else {
			        System.out.println("Failed to update wallet amount.");
			    }
			    if (done == 1 && increased == 1) {		
			    	PrintWriter out = response.getWriter();
			    	
			    	out.println("<script type='text/javascript'>");
			    	out.println("alert('Delivery Confirmed..!');");
			    	out.println("window.location = 'deliver/myorders.jsp';");
			    	out.println("</script>");
			    }
			} 
			catch (Exception e) {
			    e.printStackTrace(); 
			}
		} 
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}		
	}
}
