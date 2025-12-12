package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

import Connection.DBConnection;

public class walletServiceController {
	public static boolean createWallet(String email) {
		boolean isSuccess = false;
		try(Connection conn = DBConnection.getConnection()) {
			String sql = "INSERT INTO wallet (s_email, amount, last_withdrawal_date) VALUES (?, '0.0', CURRENT_DATE)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, email);
			System.out.println(stmt);
			int result = stmt.executeUpdate();
			System.out.println(stmt);
			
			if (result == 1) {				
				isSuccess = true;
			}
		}
		catch (Exception e) {
			System.out.println("Fetch  failed");
		}
		
		return isSuccess;
	}
	
	
	public static HashMap<String,String> getWalletDetails(String email) throws ClassNotFoundException, SQLException {
		HashMap<String,String> wallet = new HashMap<>();
		try(Connection conn = DBConnection.getConnection()) {
			String sql = "SELECT * FROM wallet WHERE s_email = '"+email+"' LIMIT 1";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			System.out.println(stmt);
			
			if (rs.next()) {				
				wallet.put("amt", rs.getString("amount"));
				wallet.put("wdate", rs.getString("last_withdrawal_date"));
			}
		}
		catch (Exception e) {
			System.out.println("Fetch  failed");
		}
		
		return wallet;
	}
	
	public static boolean updateWalletAmt(String email, String wamt, String avamt) throws ClassNotFoundException, SQLException {
		boolean isSuccess = false;
		
		Double w_amt = Double.parseDouble(wamt);
		System.out.println(w_amt);
		Double av_amt = Double.parseDouble(avamt);
		System.out.println(av_amt);
		
		Double f_amt = av_amt - w_amt;
		
		String famt = Double.toString(f_amt);
		System.out.println(famt);
		
		try (Connection conn = DBConnection.getConnection()) {
			String sql = "UPDATE wallet SET amount = ? WHERE s_email = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, famt);
			stmt.setString(2, email);
			System.out.println(stmt);
			int result = stmt.executeUpdate();
			
			if (result == 1) {
				isSuccess = true;
			}
		}
		catch (Exception e) {
			System.out.println("Wallet Update failed");
		}
		
		return isSuccess;
	}
}
