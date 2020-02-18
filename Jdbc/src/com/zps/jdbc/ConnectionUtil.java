package com.zps.jdbc;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionUtil {
	private static InputStream is = null;
	private static String myurl = "jdbc.properties";
	private static Properties p = null;
	private static Connection conn = null;
    private static PreparedStatement pstmt = null;
    public ResultSet rs = null;
    
    private static ConnectionUtil connectionUtil = null;
	
    
    private ConnectionUtil(){
    	
    }
    
    public static ConnectionUtil instansof(){
    	if(connectionUtil == null){
    		connectionUtil = new ConnectionUtil();
    	}
    	return connectionUtil;
    }
    
    public static ConnectionUtil instansof(String url){
    	if(connectionUtil == null){
    		connectionUtil = new ConnectionUtil();
    	}
    	myurl = url;
    	return connectionUtil;
    }
    
    
	static{
		is = ConnectionUtil.class.getClassLoader().getResourceAsStream(myurl);
		try {
			p = new Properties();
			p.load(is);
			String jdbcDriver = p.getProperty("jdbcDriver");
			Class.forName(jdbcDriver);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取连接对象的方法
	 * @return 连接对象
	 */
	public Connection getConnection() {
		
		String jdbcUrl = p.getProperty("jdbcUrl");
		System.out.println(jdbcUrl);
		String username = p.getProperty("username");
		String password = p.getProperty("password");
		try {
			conn = DriverManager.getConnection(jdbcUrl,username,password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	/**
     * 关闭资源
     */
    protected void closeAll() {
        try {
            if (this.rs != null) {
                rs.close();
            }
            if (this.pstmt != null) {
                pstmt.close();
            }
            if (this.conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
    }
}
