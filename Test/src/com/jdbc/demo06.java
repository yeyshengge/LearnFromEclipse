package com.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class demo06 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn =null;
		PreparedStatement ps1 =null;
		PreparedStatement ps2 =null;
		try {
			//加载驱动
			Class.forName("com.mysql.jdbc.Driver");
			
			//建立连接
			conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/student","root","16436130");

	conn.setAutoCommit(false);
			ps1 =conn.prepareStatement("insert into students (name,subject) values (?,?)");
            ps1.setObject(1, "赵敏");
			ps1.setObject(2, "chinese");
			ps1.execute();
			
			System.out.println("赵敏");
			ps2 =conn.prepareStatement("insert into students (name,subject) values (?,?,?)");
            ps2.setObject(1, "张无忌");
			ps2.setObject(2, "chinese");
			ps2.execute();
			System.out.println("张无忌");
			
			
			
			conn.commit();
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				conn.rollback();//回滚
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {//关闭顺序：resultest-->statement-->connection这样的顺序.
			
			}if(ps1!=null) {
				try {
					ps1.close();
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
		