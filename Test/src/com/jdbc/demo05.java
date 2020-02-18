package com.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class demo05 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn =null;
		Statement stmt =null;
		ResultSet rs=null;
		try {
			//��������
			Class.forName("com.mysql.jdbc.Driver");
			
			//��������
			conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/student","root","16436130");
            
			conn.setAutoCommit(false);
			
			stmt =conn.createStatement();
			
			for(int i=0;i<5;i++) {
				stmt.addBatch("insert into students(name,subject,grade) values ('����','math',60"+i+")");
			}
			stmt.executeBatch();
			conn.commit();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {//�ر�˳��resultest-->statement-->connection������˳��.
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}if(stmt!=null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
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