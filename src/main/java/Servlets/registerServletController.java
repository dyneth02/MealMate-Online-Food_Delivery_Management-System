package Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import Models.guestUserModel;
import Models.userModel;
import Services.userServiceController;

public class registerServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uname = request.getParameter("username");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String pass = request.getParameter("password");
		String address = request.getParameter("address");
		
		guestUserModel unreg = new guestUserModel(uname, pass, email, phone, address);
		
		
		try {
			if (userServiceController.addUser(unreg)) {
				RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
				dis.forward(request, response);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
