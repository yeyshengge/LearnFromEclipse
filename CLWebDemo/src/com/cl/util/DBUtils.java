package com.cl.util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtils {
	public Connection conn ;
	/**
	 * ��ȡ����
	 * @return
	 */
	public DBUtils(){
		DBPool dbPool = DBPool.getInstance();
		conn = dbPool.getConnection().getConnection();
	}
	
	/**
	 * ����Statement����
	 * @return
	 * @throws SQLException
	 */
	public Statement statement() throws SQLException{
		return conn.createStatement();
	}
	
	/**
	 * ����PreparedStatement����
	 * @param sql
	 * @return
	 * @throws SQLException
	 */
	public  PreparedStatement preparedStatement(String sql) throws SQLException{
		return conn.prepareStatement(sql);
	}
	/**
	 * �����洢���̶���
	 * {call insert_emp(emp_code in varchar2,rs out SYS_REFCURSOR)}
	 * @param sql
	 * @return
	 * @throws SQLException
	 */
	public CallableStatement callableStatement(StringBuffer sql) throws SQLException{
		sql.insert(0, "{call ").append(" }");
		return conn.prepareCall(sql.toString());
	}
	/**
	 * ����ResultSet����
	 * @param sql
	 * @return
	 * @throws SQLException
	 */
	public ResultSet resultSet(String sql) throws SQLException{
		return preparedStatement(sql).executeQuery();
	}
	
	/**
	 * �ر�ʹ�ö���
	 * @param obj
	 * @throws SQLException
	 */
	public  void close(Object obj) throws SQLException{
		if(obj==null){
			return;
		}
		if(obj instanceof ResultSet){
			((ResultSet) obj).close();
		}
		if(obj instanceof PreparedStatement){
			((PreparedStatement) obj).close();
		}
		if(obj instanceof CallableStatement){
			((CallableStatement) obj).close();
		}
	}
	
	
}
