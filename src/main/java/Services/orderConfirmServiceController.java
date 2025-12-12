package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import Connection.DBConnection;

public class orderConfirmServiceController implements Runnable {
    private String query;
    private Object[] parameters;

    public orderConfirmServiceController(String q, Object[] obj) {
        this.query = q;
        this.parameters = obj;
    }

    @Override
    public void run() {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(query);

            for (int i = 0; i < parameters.length; i++) {
                stmt.setObject(i + 1, parameters[i]);
                System.out.println(stmt);
            }

            int affectedRows = stmt.executeUpdate();

            if (affectedRows >= 1) {
                System.out.println("Operation successful, affected rows: " + affectedRows);
            } else {
                System.out.println("No rows were affected by the operation.");
            }

        } catch (Exception e) {
            System.out.println("Error executing query: " + e.getMessage());
            e.printStackTrace(); 

        }
    }
}
