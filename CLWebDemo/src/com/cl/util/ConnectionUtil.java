package com.cl.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionUtil {
	
	//���ݿ�����״̬
	//true����ʾ����������ʹ�ã�false����ʾ�����Ӵ��ڿ���״̬
	private  boolean isFree = true;
	
	//���ݿ����Ӷ���
	private Connection conn;
	
	/**
	 * ���õ�ǰ�����ݿ����Ӷ����ʹ��״̬
	 * ��ʼ��true
	 * @param isFree
	 */
	public  void setIsFree(boolean isFree){
		this.isFree = isFree;
	}
	
	/**
	 * ���ص�ǰ���ݿ����ӵ�ʹ��״̬
	 * @return
	 */
	public boolean getIsFree(){
		return isFree;
	}
	
	/**
	 * ��ȡ���ݿ�����
	 * @return
	 */
//	public Connection connection() {
//		if(conn!=null){
//			return conn;
//		}
//		try {
//			conn =  DriverManager.getConnection(DB.DB_URL,DB.DB_NAME,DB.DB_PASSWORD);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return conn;
//	}
	
	/**
	 * �������ݿ�����
	 * @param conn
	 */
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	
//	private static InputStream is = null;
//	private static String myurl = "jdbc.properties";
//	private static Properties p = null;
//	private static Connection conn = null;
    private static PreparedStatement pstmt = null;
    public ResultSet rs = null;
    
//    private static ConnectionUtil connectionUtil = null;
	
    
//    private ConnectionUtil(){
//    	
//    }
    
//    public static ConnectionUtil instansof(){
//    	if(connectionUtil == null){
//    		connectionUtil = new ConnectionUtil();
////    		conn =  DriverManager.getConnection(DB.DB_URL,DB.DB_NAME,DB.DB_PASSWORD);
//    	}
//    	return connectionUtil;
//    }
    
//    public static ConnectionUtil instansof(String url){
//    	if(connectionUtil == null){
//    		connectionUtil = new ConnectionUtil();
//    	}
//    	myurl = url;
//    	return connectionUtil;
//    }
    
    
	static{
		try {
//			p = new Properties();
//			p.load(is);
//			String jdbcDriver = p.getProperty("jdbcDriver");
//			Class.forName(jdbcDriver);
			Class.forName(DB.DB_DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * ��ȡ���Ӷ���ķ���
	 * @return ���Ӷ���
	 */
	public Connection getConnection() {
		
//		String jdbcUrl = p.getProperty("jdbcUrl");
//		String username = p.getProperty("username");
//		String password = p.getProperty("password");
		try {
//			conn = DriverManager.getConnection(jdbcUrl,username,password);
			conn = DriverManager.getConnection(DB.DB_URL,DB.DB_NAME,DB.DB_PASSWORD);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	/**
     * �ر���Դ
     */
    public void closeAll() {
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
