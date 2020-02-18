package com.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class demo04 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn =null;
		PreparedStatement ps =null;
		ResultSet rs=null;
		try {
			//加载驱动
			Class.forName("com.mysql.jdbc.Driver");
			
			//建立连接
			conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/student","root","16436130");

			String sql="select * from students where id>?";//?占位符，防止sql注入
			ps =conn.prepareStatement(sql);
            ps.setObject(1, 3);//id大于三
			rs=ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getInt(1)+"---"+rs.getString(2)+"---"+rs.getString(3));
			}
			
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {//关闭顺序：resultest-->statement-->connection这样的顺序.
			if(rs!=null) {
				try {
					rs.close();
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
