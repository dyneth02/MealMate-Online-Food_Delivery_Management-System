package Services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

import Connection.DBConnection;
import Models.deliveryPersonModel;
import Models.guestUserModel;

public class staffServiceController {
	public static boolean addMember(deliveryPersonModel um) {
			
			boolean isSuccess = false;
			
			try {
				String uemail = um.getEmail();
				String uuname = um.getUsername();
				String upass = um.getPassword();
				String uphone = um.getPhone_number();
				
				
				Statement stmt = DBConnection.getConnection().createStatement();
				
				String sql;
				
				try {
					sql = "INSERT INTO `staff`(`s_email`, `s_password`, `s_username`, `s_phone_number`) "
								+ "VALUES ('"+uemail+"', '"+upass+"', '"+uuname+"', '"+uphone+"');";
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
	
	public static HashMap<String,String> getStaffMember(String email) throws ClassNotFoundException, SQLException {
		HashMap<String,String> member = new HashMap<>();
		try(Connection conn = DBConnection.getConnection()) {
			String sql = "SELECT * FROM staff WHERE s_email = '"+email+"' LIMIT 1";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			System.out.println(stmt);
			
			if (rs.next()) {				
				member.put("uname", rs.getString("s_username"));
				member.put("phone", rs.getString("s_phone_number"));
			}
		}
		catch (Exception e) {
			System.out.println("Fetch  failed");
		}
		
		return member;
	}
	
	public static boolean validateStaff(String email, String password) throws ClassNotFoundException, SQLException {
			
		boolean isSuccess = false;
		
		String vemail = email;
		String vpassword = password; 
		
		try {
			Statement stmt = DBConnection.getConnection().createStatement();
			String sql = "SELECT * FROM staff WHERE s_email='"+vemail+"' AND s_password='"+vpassword+"'";
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
