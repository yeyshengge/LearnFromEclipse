package com.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class demo03 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn =null;
		PreparedStatement ps =null;
		try {
			//��������
			Class.forName("com.mysql.jdbc.Driver");
			
			//��������
			conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/student","root","16436130");

			String sql="insert into students(name,sex,subject,address,grade,tel) values(?,?,?,?,?,?)";//?ռλ������ֹsqlע��
			ps =conn.prepareStatement(sql);
//			ps.setString(1, "���");
//			ps.setString(2, "��");
//			ps.setString(3, "chinese");
//			ps.setString(4, "���ϳ���");
//			ps.setInt(5, 96);
//			ps.setInt(6, 1557689);
			
//			ps.setObject(parameterIndex, x);//�ʺ�ȫ�����ͣ���Ҫ��ʲôstring,int
			
			
			ps.execute();
			
			
			
			
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
			}if(ps!=null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}	
	}
		}
