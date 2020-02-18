package com.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class demo {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	Connection conn =null;	
try {
	//¼ÓÔØÇý¶¯
	Class.forName("com.mysql.jdbc.Driver");
	long start =System.currentTimeMillis();
	
	 conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/student","root","16436130");
	long end =System.currentTimeMillis();
	System.out.println(conn);
	System.err.println(end-start);
	
	
	
	
	
} catch (ClassNotFoundException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}	finally {
	if(conn!=null) {
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
		
	}

}
