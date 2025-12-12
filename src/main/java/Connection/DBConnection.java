package Connection;
import java.sql.Connection; //pkg import
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnection {
	public static Connection getConnection() throws SQLException, ClassNotFoundException{		
		String url = "jdbc:mysql://localhost:3306/ofs";
		String username = "root";
		String password = "";
		
		
		Class.forName("com.mysql.jdbc.Driver"); // loading driver
		Connection conn = DriverManager.getConnection(url,username,password);

		
		return conn;
		
	}
	
}