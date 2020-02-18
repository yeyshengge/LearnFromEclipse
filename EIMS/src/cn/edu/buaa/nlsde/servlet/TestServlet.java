package cn.edu.buaa.nlsde.servlet;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import cn.edu.buaa.nlsde.db.*;
public class TestServlet extends HttpServlet {
	private DBConnectionManager connMgr;
	public void init(ServletConfig conf) throws ServletException {
		super.init(conf);
		connMgr = DBConnectionManager.getInstance();
	}
	public void service(
		HttpServletRequest req,
		HttpServletResponse res)
		throws IOException {
		res.setContentType("text/html; charset=gb2312");
		PrintWriter out = res.getWriter();
		Connection con = connMgr.getConnection("eims");
		if (con == null) {
			out.println("不能获取数据库连接.");
			return;
		}
		ResultSet rs = null;
		ResultSetMetaData md = null;
		Statement stmt = null;
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM PSLogins");
			md = rs.getMetaData();
			out.println("<H1>用户数据</H1>");
			while (rs.next()) {
				out.println("<BR>");
				for (int i = 1; i < md.getColumnCount(); i++) {
					out.print(rs.getString(i) + ", ");
				}
			}
			stmt.close();
			rs.close();
		}
		catch (SQLException e) {
			e.printStackTrace(out);
		}
		connMgr.freeConnection("eims", con);
	}
	public void destroy() {
		connMgr.release();
		super.destroy();
	}
}
