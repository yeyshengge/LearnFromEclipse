//连接数据库的Java Bean文件名DBConnBean.java
package cn.edu.buaa.nlsde.bean;
import java.sql.*;
public class DBConnBean {
	public DBConnBean() {
	}
	//declare variable
	private Connection conn = null;
	ResultSet rs = null;
	private String server = "127.0.0.1";
	private String port = "3306";
	private String db = "test";
	private String user = "root";
	private String pass = "password";
	private String drivername = "com.mysql.jdbc.Driver";
	private String URL =
		"jdbc:mysql://"
			+ server
			+ ":"
			+ port
			+ "/"
			+ db
			+ "?user="
			+ user
			+ "&password="
			+ pass;
	public Connection getConn() { //get database connection
		try {
			Class.forName(drivername).newInstance();
			conn = DriverManager.getConnection(URL);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return this.conn;
	}
	public void setServer(String str) { //set server name
		server = str;
	}
	public void setPort(String str) { //set server port
		port = str;
	}
	public void setDB(String str) { //set db name
		db = str;
	}
	public void setUser(String str) { //set user name
		user = str;
	}
	public void setPass(String str) { //set user name
		pass = str;
	}
	public ResultSet executeSQL(String str) {
		try {
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(str);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return this.rs;
	}
}
