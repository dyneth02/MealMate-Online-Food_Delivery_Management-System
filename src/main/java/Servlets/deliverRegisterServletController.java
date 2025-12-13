package Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import Models.deliveryPersonModel;
import Models.guestUserModel;
import Models.userModel;
import Services.staffServiceController;
import Services.userServiceController;
import Services.walletServiceController;

public class deliverRegisterServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uname = request.getParameter("username");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String pass = request.getParameter("password");
		
		deliveryPersonModel unreg = new deliveryPersonModel(uname, pass, email, phone);
		
		try {
			if (staffServiceController.addMember(unreg)) {
				if(walletServiceController.createWallet(email)) {
					PrintWriter out = response.getWriter();
					
					out.println("<script type='text/javascript'>");
			        out.println("alert('Registration is Successful..!');");
			        out.println("window.location = 'deliver/deliverlogin.jsp';");
			        out.println("</script>");
				}
			}
			else {
				System.out.println("Query failed");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
