package com.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Statement;

public class demo02 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn=null;
		java.sql.Statement stmt=null;
		try {
			//��������
			Class.forName("com.mysql.jdbc.Driver");
		
			//��������
			 conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/student","root","16436130");
	stmt=conn.createStatement();
	//����һ����¼
//	String sql ="insert into students (name,sex,subject,address,grade,tel) values ('С��','��','���ϳ���','histroy',99,'1863')";
//	stmt.execute(sql);
	//ɾ��һ�м�¼
	String sql ="delete from students where id=5";
	stmt.execute(sql);
			
			
			
			
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
			}if(stmt!=null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		}	
	}
		
