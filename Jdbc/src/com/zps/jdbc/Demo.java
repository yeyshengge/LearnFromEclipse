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
//			//加载驱动
//			Class.forName("com.mysql.jdbc.Driver");
//			//通过驱动管理器来获取链接对象
//			Connection conn = DriverManager.getConnection("","","");
//			String sql = "select * from student";
//			//通过链接对象获取到语句对象(预编译语句对象)
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
//			//关闭连接，释放资源
//		}
//	}
//}
