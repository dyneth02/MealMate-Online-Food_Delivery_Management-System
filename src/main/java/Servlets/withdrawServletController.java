package Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import Services.walletServiceController;

public class withdrawServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = (String) request.getSession().getAttribute("semail");
		String wamt = request.getParameter("withdrawalAmount");
		String avamt = request.getParameter("totalAmount");
		
		try {
			if (walletServiceController.updateWalletAmt(email, wamt, avamt)) {
				PrintWriter out = response.getWriter();
				
				out.println("<script type='text/javascript'>");
		        out.println("alert('Withdrawal is Successful..!');");
		        out.println("window.location = 'deliver/staffdashboard.jsp';");
		        out.println("</script>");
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

}
