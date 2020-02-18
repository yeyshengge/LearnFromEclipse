/**
 * ��ѯ�ض�ʱ��ε�����
 */

package com.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.xml.crypto.Data;

public class demo08 {
public static long str2Date(String dateStr) {
	DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
try {
	return format.parse(dateStr).getTime();
} catch (ParseException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	return 0;
}
}
	
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Connection conn =null;
		PreparedStatement ps =null;
		ResultSet rs=null;
		try {
			//��������
			Class.forName("com.mysql.jdbc.Driver");
			
			//��������
			conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/test01","root","16436130");
  
		ps=	conn.prepareStatement("select * from students where regTime>? and regTime<?");
	
			java.sql.Date start =new java.sql.Date(str2Date("2019-4-18 10:23:45"));
			java.sql.Date end =new java.sql.Date(str2Date("2019-4-23 10:23:45"));
			
		ps.setObject(1, start);
		ps.setObject(2, end);
		
		rs=ps.executeQuery();
		while(rs.next()) {
			System.out.println(rs.getInt("id")+"--"+rs.getString("name"));
		}
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				conn.rollback();//�ع�
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {//�ر�˳��resultest-->statement-->connection������˳��.
			
			}if(ps!=null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(rs!=null) {
				try {
					rs.close();
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
		