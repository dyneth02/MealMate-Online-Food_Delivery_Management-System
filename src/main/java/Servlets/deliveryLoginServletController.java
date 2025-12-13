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

import Services.staffServiceController;
import Services.userServiceController;

public class deliveryLoginServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		
		String vemail = request.getParameter("email");
		String vpassword = request.getParameter("password");
		
		try {
			if(staffServiceController.validateStaff(vemail, vpassword)) {
				
				session.setAttribute("login_status","true");
				session.setAttribute("semail", vemail);
				
				System.out.println("Login Wada");
				System.out.println("Email eka : " + session.getAttribute("semail"));
				
				RequestDispatcher dis = request.getRequestDispatcher("deliver/staffdashboard.jsp");
				dis.forward(request, response);
			}
			else {
				PrintWriter out = response.getWriter();
		    	
		    	out.println("<script type='text/javascript'>");
		    	out.println("alert('Invalid Credentials');");
		    	out.println("window.location = 'deliver/deliverlogin.jsp';");
		    	out.println("</script>");
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
