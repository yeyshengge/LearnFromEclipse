package cn.edu.buaa.nlsde.db;

import java.util.ResourceBundle;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class DBConnect {
	Connection conn = null;
	/**
	 * ͨ��JDBC��ȡStatement
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
	 * ͨ��JDBC:ODBC��ȡStatement
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
	 * ͨ��Context��ȡStatement
	 * ���������ݿ����ӳ�
	 * @param resname
	 * @return
	 * @throws Exception
	 */
	public Connection getPoolConn(String resname) throws Exception {
		Context initCtx = new InitialContext();
		if (initCtx == null) {
			throw new Exception("���ܻ�ȡContext!");
		}
		DataSource ds = (DataSource) initCtx.lookup("java:comp/env/" + resname);
		conn = ds.getConnection();
		return conn;
	}
	/**
	 * ͨ���Զ���DBConnectionManager��ȡStatement 
	 * �Զ������ݿ����ӳ�
	 * @param resname
	 * @return
	 * @throws Exception
	 */
	public Connection getConnPoolConn(String resname) throws Exception {
		DBConnectionManager connMgr = DBConnectionManager.getInstance();
		conn = connMgr.getConnection(resname, 3000);
		if (conn == null) {
			System.out.println("���ܻ�ȡ���ݿ�����.");
			return null;
		}
		return conn;
	}
}
