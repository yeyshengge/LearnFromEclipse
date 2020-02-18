<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>
<%@ page import="cn.edu.buaa.nlsde.md5.MD5"%>
<jsp:useBean id="poolBean" class="cn.edu.buaa.nlsde.bean.PoolBean"
	scope="page"></jsp:useBean>
<%String TheMessage = "";
Integer NumAttempts = new Integer(0);
//判断用户是否提交表单
if (request.getParameter("Login") == null) {
	if (session.getAttribute("NumAttempts") != null) {
		NumAttempts = (Integer)session.getAttribute("NumAttempts");
	}
	Enumeration e = session.getAttributeNames();
	while (e.hasMoreElements()) {
		session.removeAttribute((String)e.nextElement());
	}
	session.setAttribute("NumAttempts", NumAttempts);
	TheMessage = "请在下面登录:(缺省管理员用户名:EIMS,密码:eims)";
}
//校验用户提交的用户信息
else {
	String TheUsername = request.getParameter("UserName");
	String ThePassword = request.getParameter("Password");
	if (TheUsername != null && ThePassword != null) {
		ThePassword = new MD5().getMD5ofStr(ThePassword);
		try {
			//Connection conn = (new DBConnect()).getODBCConn("EIMS");
			Connection conn =
				(new DBConnect()).getConnPoolConn("eims");
			//poolBean.initializePool();
			//Connection conn = poolBean.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet RSLogin =
				stmt.executeQuery(
					"select LoginID,Name,Password,Department,EmailAddress,"
						+ "Position,InternalPhone,HomePhone,MobilePhone,MSN,"
						+ "Birthday,HomeAddress,IsSystemManager,IsFinancialManager "
						+ "from PSLogins where LoginID='"
						+ TheUsername
						+ "' and Password='"
						+ ThePassword
						+ "'");
			while (RSLogin.next()) {
				session.setAttribute(
					"ID",
					RSLogin.getString("LoginID"));
				session.setAttribute(
					"Name",
					RSLogin.getString("Name"));
				session.setAttribute(
					"Password",
					RSLogin.getString("Password"));
				session.setAttribute(
					"Department",
					RSLogin.getString("Department"));
				session.setAttribute(
					"EmailAddress",
					RSLogin.getString("EmailAddress"));
				session.setAttribute(
					"Position",
					RSLogin.getString("Position"));
				session.setAttribute(
					"InternalPhone",
					RSLogin.getString("InternalPhone"));
				session.setAttribute(
					"HomePhone",
					RSLogin.getString("HomePhone"));
				session.setAttribute(
					"MobilePhone",
					RSLogin.getString("MobilePhone"));
				session.setAttribute("MSN", RSLogin.getString("MSN"));
				session.setAttribute(
					"Birthday",
					RSLogin.getString("Birthday"));
				session.setAttribute(
					"HomeAddress",
					RSLogin.getString("HomeAddress"));
				session.setAttribute(
					"IsSystemManager",
					RSLogin.getString("IsSystemManager"));
				session.setAttribute(
					"IsFinancialManager",
					RSLogin.getString("IsFinancialManager"));
				DBConnectionManager.getInstance().freeConnection(
					"eims",
					conn);
				//poolBean.releaseConnection(conn);
				response.sendRedirect("./html/home.jsp");
			}
			session.setAttribute(
				"NumAttempts",
				new Integer(
					((Integer)session.getAttribute("NumAttempts"))
						.intValue()
						+ 1));
			if (((Integer)session.getAttribute("NumAttempts"))
				.intValue()
				< 4) {
				TheMessage =
					"登录不成功，还有"
						+ (4
							- ((Integer)session
								.getAttribute("NumAttempts"))
								.intValue())
						+ "次机会，请重试:";
			}
			else {
				TheMessage = "登录不成功，登录次数已满，无法重试";
			}
			DBConnectionManager.getInstance().freeConnection(
				"eims",
				conn);
			//poolBean.releaseConnection(conn);
		}
		catch (Exception ex) {
			System.err.println(ex);
		}
	}
	else {
		TheMessage = "用户名或者密码输入不合格式";
	}
}
%>


<html>
<head>
<title>系统登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>

<table width=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>
	<tr bgcolor=white>
		<td valign=middle><img src="image/jsplogo.jpg" width=796 height=100></td>
	</tr>
</table>
<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="13"><img src="./image/banner2.jpg" width="800" height="12"></td>
	</tr>
</table>
<table width=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>
	<tr>
		<td colspan=3>
		<div align="center"><font color=white> 公司办公信息管理系统->登录页面 </font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="./html/home.jsp"><font color="#104DAD">返回上一站点</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href="help.jsp"><font color="#104DAD">系统使用说明</font></a></td>
	</tr>
</table>
<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="13"><img src="./image/banner2.jpg" width="800" height="12"></td>
	</tr>
</table>

<br>
<table width=800 border="0" align=center bgcolor=#3466BB height=350>
	<tr bgcolor=white>
		<td align=center bgcolor=#B6CAEB class=itm height="8" colspan="2"><br>
		<%=TheMessage%>
		<div align="center"><%if (!TheMessage.equals("登录不成功，登录次数已满，无法重试")) {%>
		<form name="form" method="post" action="login.jsp">
		<p><font color="#3466BB">用户</font> <input class=itm name=UserName
			size=15></p>
		<p><font color="#3466BB">口令</font> <input class=itm name=Password
			size=15 type=password> <br>
		<br>
		<input type="submit" name="Login" value="登录"
			style="border: 1px solid #B6CAEB; background-color: #3466BB; color: #FFFFFF">
		<input type="reset" name="Reset" value="重设"
			style="border: 1px solid #B6CAEB; background-color: #3466BB; color: #FFFFFF">
		</p>
		</form>
		<%}
%></div>
		</td>
	</tr>
</table>

</body>
</html>
