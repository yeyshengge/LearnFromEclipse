package com.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.xml.crypto.Data;

public class demo7 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn =null;
		PreparedStatement ps1 =null;
		PreparedStatement ps2 =null;
		try {
			//��������
			Class.forName("com.mysql.jdbc.Driver");
			
			//��������
			conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/test01","root","16436130");

	conn.setAutoCommit(false);
			ps1 =conn.prepareStatement("insert into students (name,subject,regTime) values (?,?,?)");
            ps1.setObject(1, "����");
			ps1.setObject(2, "chinese");
			
			
			
			
			java.sql.Date date=new java.sql.Date(System.currentTimeMillis());
			ps1.setDate(3, date);
			ps1.execute();
			
			
			System.out.println("����");
			ps2 =conn.prepareStatement("insert into students (name,subject) values (?,?)");
            ps2.setObject(1, "���޼�");
			ps2.setObject(2, "chinese");
			ps2.execute();
			System.out.println("���޼�");
			
			
			
			conn.commit();
			
			
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
		