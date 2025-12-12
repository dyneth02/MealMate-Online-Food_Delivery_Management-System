package Services;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

import Connection.DBConnection;
import Models.cartItemModel;
import jakarta.servlet.http.HttpServletRequest;

public class dishServiceController {
	
	public static boolean addDishesToCart(cartItemModel cim) throws ClassNotFoundException, SQLException {
		boolean isSuccess = false;
		
		try (Connection conn = DBConnection.getConnection()) {
			String sql = "INSERT INTO cart (d_id, rid, u_email, d_title, u_price, qty, tot_price) VALUES (? , ? , ? , ? , ? , ? , ?)";
			
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, cim.getDid());
				stmt.setInt(2, cim.getRid());
				stmt.setString(3, cim.getUemail());
				stmt.setString(4, cim.getDtitle());
				stmt.setDouble(5, cim.getUprice());
				stmt.setInt(6, cim.getQty());
				stmt.setDouble(7, cim.getTprice());
				
				System.out.println(stmt);
				
				int i = stmt.executeUpdate();
				
				if (i == 1) {
					isSuccess = true;
				}
				
			} 
			catch (SQLException e) {
				System.out.println("Statement awlak" + e);
			}
			
		}
		catch (SQLException e) {
			System.out.println("Loku awlak" + e);
		}
		
		return isSuccess;
		
	}
 	
	
	
	public static HashMap<String, HashMap<String, String>> showDishes(String rid) throws ClassNotFoundException {
	    HashMap<String, HashMap<String, String>> dishMap = new HashMap<>();

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM dishes WHERE rs_id = ?")) {
	         
	        stmt.setString(1, rid);
	        try (ResultSet rs = stmt.executeQuery()) {
	        	while (rs.next()) {
	        	    String dish_id = Integer.toString(rs.getInt("d_id"));
	        	    HashMap<String, String> dishDetails = new HashMap<>();
	        	    
	        	    dishDetails.put("dtitle", rs.getString("title"));
	        	    
	        	    try {
						BigDecimal price = rs.getBigDecimal("price");
						if (price != null) {
						    dishDetails.put("dprice", price.toString());
						} else {
						    dishDetails.put("dprice", "0.00");
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
	        	    
	        	    dishDetails.put("dslogan", rs.getString("slogan"));
	        	    dishDetails.put("dimage", rs.getString("img"));

	        	    dishMap.put(dish_id, dishDetails);
	        	}
		    }
	        catch (SQLException e) {
		        e.printStackTrace();
		        throw new RuntimeException("Database error while fetching dishes", e);
		    }
	    }
        catch (SQLException e) {
	        e.printStackTrace();
	        throw new RuntimeException("Database function error", e);
	    }
	    
	    return dishMap;
	}

}
