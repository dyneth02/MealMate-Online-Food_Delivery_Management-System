package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

import Connection.DBConnection;

public class orderServiceController {
	public static HashMap<String, HashMap<String, String>> showOrders(String email) throws ClassNotFoundException, SQLException {
		HashMap<String, HashMap<String, String>> orders = new HashMap<>();
		String uemail = email;
		
		try (Connection con = DBConnection.getConnection()) {
			String sql = "SELECT * FROM users_orders WHERE u_email = ? ORDER BY status DESC";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1,uemail);
			System.out.println(stmt);
			ResultSet rs = stmt.executeQuery();
			
			try {
				while (rs.next()) {
					HashMap<String, String> orderDetails = new HashMap<>();
					String oid = Integer.toString(rs.getInt("o_id"));
					
					orderDetails.put("uemail", rs.getString("u_email"));
					orderDetails.put("title", rs.getString("title"));
					orderDetails.put("qty", Integer.toString(rs.getInt("quantity")));
					orderDetails.put("price", rs.getBigDecimal("price").toString());
					orderDetails.put("status", rs.getString("status") != null ? rs.getString("status") : "unknown");
					orderDetails.put("date", rs.getString("date"));
					
					orders.put(oid, orderDetails);
				}
			}
			catch (SQLException e) {
				System.out.println("Loku awlak");
				e.printStackTrace();
			}
			return orders;
		}
 	}
	
	
	public static boolean deleteOrder(String user_email, String oid) throws ClassNotFoundException, SQLException {
		boolean isSuccess = false;
		String uemail = user_email;
		String order_id = oid;
		PreparedStatement stmt;
		
		try {
			Connection conn = DBConnection.getConnection();
			String sql = "DELETE FROM users_orders WHERE o_id = ? AND u_email = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, order_id);
			stmt.setString(2, uemail);
			System.out.println(stmt);
			int result = stmt.executeUpdate();
			
			if (result == 1) {
				isSuccess = true;
			}
			else {
				System.out.println("Wada naa");
			}
		} 
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public static HashMap<String, HashMap<String, String>> showAllOrders() throws ClassNotFoundException, SQLException {
		HashMap<String, HashMap<String, String>> allorders = new HashMap<>();
		
		try (Connection con = DBConnection.getConnection()) {
			String sql = "SELECT o.o_id, u.email, u.address, u.phone_number, o.title, o.quantity, o.price, o.status, o.date "
						+ "FROM users u "
						+ "INNER JOIN users_orders o "
						+ "ON u.email = o.u_email ORDER BY o_id DESC";
			
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			try {
				while (rs.next()) {
					HashMap<String, String> orderDetails = new HashMap<>();
					String oid = Integer.toString(rs.getInt("o_id"));
					
					orderDetails.put("uemail", rs.getString("email"));
					orderDetails.put("address", rs.getString("address"));
					orderDetails.put("phone", rs.getString("phone_number"));
					orderDetails.put("title", rs.getString("title"));
					orderDetails.put("qty", Integer.toString(rs.getInt("quantity")));
					orderDetails.put("price", rs.getBigDecimal("price").toString());
					orderDetails.put("status", rs.getString("status") != null ? rs.getString("status") : "unknown");
					orderDetails.put("date", rs.getString("date"));
					
					allorders.put(oid, orderDetails);
				}
			}
			catch (SQLException e) {
				System.out.println("Loku awlak");
				e.printStackTrace();
			}
			return allorders;
		}
		
	}
	
	public static HashMap<String, HashMap<String, String>> showMyOrders(String email) throws ClassNotFoundException, SQLException {
		HashMap<String, HashMap<String, String>> myorders = new HashMap<>();
		
		try (Connection con = DBConnection.getConnection()) {
			String sql = "SELECT o.o_id, u.email, u.address, u.phone_number, o.title, o.quantity, o.price, o.status, o.date "
					+ "FROM users u "
					+ "INNER JOIN users_orders o "
					+ "ON u.email = o.u_email "
					+ "INNER JOIN deliveries d "
					+ "ON o.o_id = d.o_id "
					+ "WHERE d.s_email = '"+email+"'"
					+ " ORDER BY o_id DESC";
			
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			try {
				while (rs.next()) {
					HashMap<String, String> orderDetails = new HashMap<>();
					String oid = Integer.toString(rs.getInt("o_id"));
					
					orderDetails.put("uemail", rs.getString("email"));
					orderDetails.put("address", rs.getString("address"));
					orderDetails.put("phone", rs.getString("phone_number"));
					orderDetails.put("title", rs.getString("title"));
					orderDetails.put("qty", Integer.toString(rs.getInt("quantity")));
					orderDetails.put("price", rs.getBigDecimal("price").toString());
					orderDetails.put("status", rs.getString("status") != null ? rs.getString("status") : "unknown");
					orderDetails.put("date", rs.getString("date"));
					
					myorders.put(oid, orderDetails);
				}
			}
			catch (SQLException e) {
				System.out.println("Loku awlak");
				e.printStackTrace();
			}
			return myorders;
		}
		
	}
	
	
}
