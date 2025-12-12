package Services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import Connection.DBConnection;

public class restaurantServiceController {

    public static HashMap<String, HashMap<String, String>> showRestaurant() throws ClassNotFoundException {
        String sql;
        HashMap<String, HashMap<String, String>> restMap = new HashMap<>();
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            
            sql = "SELECT * FROM restaurant";
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                String rest_id = Integer.toString(rs.getInt("rs_id"));

                HashMap<String, String> restDetails = new HashMap<>();
                restDetails.put("rtitle", rs.getString("title"));
                restDetails.put("raddress", rs.getString("address"));
                restDetails.put("rimage", rs.getString("image"));
                           
                restMap.put(rest_id, restDetails);
            }
            return restMap;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
