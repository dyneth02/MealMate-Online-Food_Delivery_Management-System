package Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import Services.orderConfirmServiceController;

public class orderNowServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<HashMap<String, String>> cart = (List<HashMap<String, String>>) request.getSession().getAttribute("cart");
        String uemail = (String) request.getSession().getAttribute("userEmail");

        String insertQuery = "INSERT INTO users_orders (u_email, title, quantity, price, status, date) VALUES (?, ?, ?, ?, ?, ?)";
        String deleteQuery = "DELETE FROM cart WHERE u_email = ?";

        if (cart != null && !cart.isEmpty()) {
            for (HashMap<String, String> item : cart) {
                String title = item.get("title");
                String quantity = item.get("quantity");
                String price = item.get("price");

                String status = "Processing";
                String currentDate = java.time.LocalDate.now().toString();

                Object[] insertParams = {uemail, title, quantity, price, status, currentDate};

                Runnable insertion = new orderConfirmServiceController(insertQuery, insertParams);
                Thread insertThread = new Thread(insertion);
                insertThread.start();
                
                try {
                    insertThread.join();
                } catch (InterruptedException e) {
                    System.out.println("Insert Thread awlak " + e);
                }
            }
        }

        Object[] deleteParams = {uemail}; 
        Runnable deletion = new orderConfirmServiceController(deleteQuery, deleteParams);
        Thread deleteThread = new Thread(deletion);
        deleteThread.start();

        try {
            deleteThread.join();
        } catch (InterruptedException e) {
            System.out.println("Delete Thread awlak " + e);
        }

        RequestDispatcher dis = request.getRequestDispatcher("your_orders.jsp");
        dis.forward(request, response);
    }
}

