/**
 * CLOB�ı������ʹ��
 */

package com.jdbc;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class demo09 {
	
		
		public static void main(String[] args) {
			// TODO Auto-generated method stub

			Connection conn =null;
			PreparedStatement ps =null;
			
			try {
				//��������
				Class.forName("com.mysql.jdbc.Driver");
				
				//��������
				conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/test01","root","16436130");
	  
			ps=	conn.prepareStatement("insert into students (name,myInfo) values (?,?)");
			ps.setString(1, "����");
			//ps.setClob(2, new FileReader(new File("D:/a.txt"))); //���ı����ݸ����
			
			
			ps.setClob(2,new BufferedReader(new InputStreamReader(new ByteArrayInputStream("aaaaabbbbb".getBytes()))));
		//�������е��ַ��������ݿ�
			
			
			
			ps.executeUpdate();
			
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
			