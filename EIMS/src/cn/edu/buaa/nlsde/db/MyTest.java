/*
 * 创建日期 2005-7-31
 */
package cn.edu.buaa.nlsde.db;
/**
 * @author Euyi
 */
import java.sql.*;
public class MyTest {
	public static void main(String[] args) {
		DBConnectionManager connMgr =
			DBConnectionManager.getInstance();
		Connection con = connMgr.getConnection("eims");
		if (con == null) {
			System.out.println("不能获取数据库连接.");
			return;
		}
		ResultSet rs = null;
		ResultSet rs2 = null;
		ResultSetMetaData md = null;
		Statement stmt = null;
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM PSLogins");
			md = rs.getMetaData();
			System.out.println("<H1>用户数据</H1>");
			while (rs.next()) {
				System.out.println("<BR>");
				for (int i = 1; i < md.getColumnCount(); i++) {
					System.out.print(rs.getString(i) + ", ");
				}
			}
			rs2 = stmt.executeQuery("select * from Positions");
			while(rs2.next()){
				System.out.println(rs2.getString("PositionName"));			
			}
			stmt.close();
			rs.close();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		connMgr.freeConnection("eims", con);
	}
}
