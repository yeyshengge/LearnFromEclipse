package cn.edu.buaa.nlsde.db;

import java.util.ResourceBundle;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class DBConnect {
	Connection conn = null;
	/**
	 * 通过JDBC获取Statement
	 * @param dbname
	 * @return
	 */
	public Connection getJDBCConn(String dbname) {
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			conn =
				DriverManager.getConnection(
					"jdbc:jtds:sqlserver://localhost:1433/"
						+ dbname
						+ ";user=sa;password=password");
		}
		catch (Exception e) {
			System.err.println(e);
		}
		return conn;
	}
	/**
	 * 通过JDBC:ODBC获取Statement
	 * @param dsname
	 * @return
	 */
	public Connection getODBCConn(String dsname) {
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			conn =
				DriverManager.getConnection(
					"jdbc:odbc:" + dsname,
					"sa",
					"password");
		}
		catch (Exception e) {
			System.out.println(e);
		}
		return conn;
	}
	/**
	 * 通过Context获取Statement
	 * 服务器数据库连接池
	 * @param resname
	 * @return
	 * @throws Exception
	 */
	public Connection getPoolConn(String resname) throws Exception {
		Context initCtx = new InitialContext();
		if (initCtx == null) {
			throw new Exception("不能获取Context!");
		}
		DataSource ds = (DataSource) initCtx.lookup("java:comp/env/" + resname);
		conn = ds.getConnection();
		return conn;
	}
	/**
	 * 通过自定义DBConnectionManager获取Statement 
	 * 自定义数据库连接池
	 * @param resname
	 * @return
	 * @throws Exception
	 */
	public Connection getConnPoolConn(String resname) throws Exception {
		DBConnectionManager connMgr = DBConnectionManager.getInstance();
		conn = connMgr.getConnection(resname, 3000);
		if (conn == null) {
			System.out.println("不能获取数据库连接.");
			return null;
		}
		return conn;
	}
}
