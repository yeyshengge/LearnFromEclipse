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
			//加载驱动
			Class.forName("com.mysql.jdbc.Driver");
		
			//建立连接
			 conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/student","root","16436130");
	stmt=conn.createStatement();
	//增加一条记录
//	String sql ="insert into students (name,sex,subject,address,grade,tel) values ('小二','男','湖南郴州','histroy',99,'1863')";
//	stmt.execute(sql);
	//删除一行记录
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
		
