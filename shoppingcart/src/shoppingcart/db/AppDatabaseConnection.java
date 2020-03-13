package shoppingcart.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class AppDatabaseConnection {// to connect with DB need url, user name, password and at last close connection.

	private static AppDatabaseConnection appDatabaseConnection = null;

	private AppDatabaseConnection() {

	}
	
	public static AppDatabaseConnection getInstance() {
		if(appDatabaseConnection == null) {
			appDatabaseConnection = new AppDatabaseConnection();
		}
		return appDatabaseConnection;
	}
	
	public Connection getConnection() throws Exception {


		Connection connection = null;
		String url = "jdbc:mysql://localhost/scdb";		
		String driver_classname  = "com.mysql.jdbc.Driver";
		String username = "root";
		String password = "root";	
		
		
		try{
			Class.forName(driver_classname);		
			connection = DriverManager.getConnection(url, username, password);				
						
		} catch(ClassNotFoundException cnfe) {
			System.err.println("Cannot load db driver: " + driver_classname);
			throw cnfe;
		} catch(SQLException sqle) {
			System.err.println("SQL Exception while getting connection: "+ sqle.getMessage());
			throw sqle;
		} catch(Exception e) {
			System.err.println(e.getMessage());
			throw e;
		}	
		
		System.out.println("Returning connection object "+connection+" DB URL: "+url);
		return connection;
	}
	public void closeConnection(Connection connection) {

		try {
			if(connection != null ) {				
				connection.close();
			}
		} catch(SQLException sqle) {
			System.err.println("Failed closing connection,  "+sqle.getMessage());
		}
	}
}
