/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DbConnect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author umchlk
 */
public class DBConnection {
    
    private static DBConnection dbConnection;
	
    private final Connection connection;
	
	private DBConnection() throws ClassNotFoundException, SQLException{
			
            Class.forName("oracle.jdbc.driver.OracleDriver");
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "EXTENSIONFINDER", "123");
			
	}
	
	public Connection getConnection(){
			return connection;
	}
	
	public static DBConnection getDBConnection()throws ClassNotFoundException,SQLException{
		
			if(dbConnection == null){
					dbConnection = new DBConnection();
			}
		return dbConnection;
	}
	
	public static Connection getConnectionToDB() throws ClassNotFoundException,SQLException{
		
		return getDBConnection().getConnection();
	
	}
	
	
	
    
}
