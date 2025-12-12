package Services;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

import com.mysql.cj.protocol.Resultset;

import Connection.DBConnection;
import Models.guestUserModel;
import Models.userModel;

public class userServiceController {
	// insert query
	public static boolean addUser(guestUserModel um) {
		
		boolean isSuccess = false;
		
		try {
			String uemail = um.getEmail();
			String uuname = um.getUsername();
			String upass = um.getPassword();
			String uphone = um.getPhone_number();
			String uaddress = um.getAddress();
			
			
			Statement stmt = DBConnection.getConnection().createStatement();
			
			String sql;
			
			try {
				sql = "INSERT INTO `users`(`username`, `password`, `email`, `phone_number`, `address`) "
							+ "VALUES ('"+uuname+"', '"+upass+"', '"+uemail+"', '"+uphone+"', '"+uaddress+"');";
				int result = stmt.executeUpdate(sql);
				if(result==1) {
					isSuccess = true;
				}
			} 
			catch (Exception e) {
				e.printStackTrace();
			}

			stmt.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	
	
	public static HashMap<String, String> showUser(String email) {
		HashMap<String, String> thisuser = new HashMap<>();
		try {
				Statement stmt = DBConnection.getConnection().createStatement();
				String sql = "SELECT * FROM users WHERE email= '"+email+"'";
				System.out.println(sql);
				ResultSet rs = stmt.executeQuery(sql);
				
				if(rs.next()) {
					thisuser.put("uname", rs.getString("username"));
					thisuser.put("password", rs.getString("password"));
					thisuser.put("phone", rs.getString("phone_number"));
					thisuser.put("address", rs.getString("address"));
				}
				stmt.close();
			} 
			catch (ClassNotFoundException e) {
				e.printStackTrace();
			} 
			catch (SQLException e) {
				e.printStackTrace();
			}
		
		return thisuser;
	}
	
	
	public static boolean updateUser(userModel um, String mail) {
		boolean isSuccess = false;
		String email = mail;
		
		try (Connection conn = DBConnection.getConnection()){
			String sql = "UPDATE users SET username = ? , password = ? , phone_number = ? , address = ? WHERE email = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, um.getUsername());
			stmt.setString(2, um.getPassword());
			stmt.setString(3, um.getPhone_number());
			stmt.setString(4, um.getAddress());
			stmt.setString(5, email);
			
			System.out.println(stmt + " : update query");
			
			int i = stmt.executeUpdate();
			
			if (i  == 1) {
				isSuccess = true;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
	
	
	public static boolean deleteUser(String mail) {
		boolean isSuccess = false;
		
		try (Connection conn = DBConnection.getConnection()){
			String sql = "DELETE FROM users WHERE emial = '"+mail+"'";
			Statement stmt = conn.createStatement();
			System.out.println(sql);
			int i = stmt.executeUpdate(sql);
			
			if(i == 1) {
				isSuccess = true;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
	
	public static boolean validateUser(String email, String password) throws ClassNotFoundException, SQLException {
		
		boolean isSuccess = false;
		
		String vemail = email;
		String vpassword = password; 
		
		try {
			Statement stmt = DBConnection.getConnection().createStatement();
			String sql = "SELECT * FROM users WHERE email='"+vemail+"' AND password='"+vpassword+"'";
			ResultSet result_set = stmt.executeQuery(sql);
			
			if(result_set.next()) {
				isSuccess = true;
			}
			stmt.close();
		} 
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return isSuccess;
		
	}
}
