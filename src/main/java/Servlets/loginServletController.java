package Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import Models.userModel;
import Services.userServiceController;

public class loginServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		String vemail = request.getParameter("vemail");
		String vpassword = request.getParameter("vpassword");
		
		try {
			if(userServiceController.validateUser(vemail, vpassword)) {
				
				session.setAttribute("login_status","true");
				session.setAttribute("userEmail", vemail);
				
				System.out.println("Login Wada");
				System.out.println("Email eka : " + session.getAttribute("userEmail"));
				
				RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
				dis.forward(request, response);
			}
			else {
				PrintWriter out = response.getWriter();
		    	
		    	out.println("<script type='text/javascript'>");
		    	out.println("alert('Invalid Credentials');");
		    	out.println("window.location = 'login.jsp';");
		    	out.println("</script>");
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
