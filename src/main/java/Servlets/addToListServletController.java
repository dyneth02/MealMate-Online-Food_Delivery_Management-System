package Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import Connection.DBConnection;

public class addToListServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uemail = request.getParameter("email");
		
		try (Connection con = DBConnection.getConnection()) {
			String sql_select = "Select * FROM users_orders WHERE status = 'Processing' AND u_email = '"+ uemail +"'";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql_select);
			
			ArrayList<String> ids = new ArrayList<>();
			
			while(rs.next()) {
				ids.add(Integer.toString(rs.getInt("o_id")));
			}
			System.out.println(ids);
			
			String sql_insert = "";
			
			String semail = (String) request.getSession().getAttribute("semail");
			System.out.println(semail);
			
			for (int i=0; i < ids.size(); i++) {
			    sql_insert = "INSERT INTO deliveries (o_id, s_email) VALUES (?, ?)";
				PreparedStatement stmt_insert = con.prepareStatement(sql_insert);
				stmt_insert.setString(1, ids.get(i)); 
				stmt_insert.setString(2, semail); 

				int result = stmt_insert.executeUpdate();
				System.out.println(result);
			}
			
			String sql_update = "";
			
			for (int i=0; i < ids.size(); i++) {
			    sql_update = "UPDATE users_orders SET status = 'Dispatch' WHERE o_id = ?";
				PreparedStatement stmt_update = con.prepareStatement(sql_update);
				stmt_update.setString(1, ids.get(i)); 

				int result = stmt_update.executeUpdate();
				System.out.println(result);
			}
			
			ids.clear();
			
			RequestDispatcher dis = request.getRequestDispatcher("deliver/myorders.jsp");
			dis.forward(request, response);
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
