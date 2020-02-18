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
			//加载驱动
			Class.forName("com.mysql.jdbc.Driver");
			
			//建立连接
			conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/student","root","16436130");

			String sql="insert into students(name,sex,subject,address,grade,tel) values(?,?,?,?,?,?)";//?占位符，防止sql注入
			ps =conn.prepareStatement(sql);
//			ps.setString(1, "高淇");
//			ps.setString(2, "男");
//			ps.setString(3, "chinese");
//			ps.setString(4, "湖南常德");
//			ps.setInt(5, 96);
//			ps.setInt(6, 1557689);
			
//			ps.setObject(parameterIndex, x);//适合全部类型，不要改什么string,int
			
			
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
