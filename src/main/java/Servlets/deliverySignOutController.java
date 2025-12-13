package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class deliverySignOutController
 */
public class deliverySignOutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalidate the session to clear all session attributes
        HttpSession session = request.getSession(false); // Get existing session, if any
        if (session != null) {
            session.invalidate(); // Invalidate the session
        }

        // Redirect to the login page or any other page after logout
        response.sendRedirect("deliver/deliverlogin.jsp"); // Adjust the path to your login page
    }

}
