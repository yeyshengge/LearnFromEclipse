//package com.zking.test;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.List;
//
//
//public class Demo {
//	public static void main(String[] args) {
//		
//		try {
//			//��������
//			Class.forName("com.mysql.jdbc.Driver");
//			//ͨ����������������ȡ���Ӷ���
//			Connection conn = DriverManager.getConnection("","","");
//			String sql = "select * from student";
//			//ͨ�����Ӷ����ȡ��������(Ԥ����������)
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ResultSet rs = ps.executeQuery();
//			List<Student> list = new ArrayList<Student>();
//			while(rs.next()){
//				Student stu = new Student();
//				stu.setSid(rs.getInt("sid"));
//				stu.setSname(rs.getString("sname"));
//				list.add(stu);
//			}
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			//�ر����ӣ��ͷ���Դ
//		}
//	}
//}
