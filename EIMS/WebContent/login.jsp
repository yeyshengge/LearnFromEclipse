<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>
<%@ page import="cn.edu.buaa.nlsde.md5.MD5"%>
<jsp:useBean id="poolBean" class="cn.edu.buaa.nlsde.bean.PoolBean"
	scope="page"></jsp:useBean>
<%String TheMessage = "";
Integer NumAttempts = new Integer(0);
//�ж��û��Ƿ��ύ��
if (request.getParameter("Login") == null) {
	if (session.getAttribute("NumAttempts") != null) {
		NumAttempts = (Integer)session.getAttribute("NumAttempts");
	}
	Enumeration e = session.getAttributeNames();
	while (e.hasMoreElements()) {
		session.removeAttribute((String)e.nextElement());
	}
	session.setAttribute("NumAttempts", NumAttempts);
	TheMessage = "���������¼:(ȱʡ����Ա�û���:EIMS,����:eims)";
}
//У���û��ύ���û���Ϣ
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
					"��¼���ɹ�������"
						+ (4
							- ((Integer)session
								.getAttribute("NumAttempts"))
								.intValue())
						+ "�λ��ᣬ������:";
			}
			else {
				TheMessage = "��¼���ɹ�����¼�����������޷�����";
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
		TheMessage = "�û��������������벻�ϸ�ʽ";
	}
}
%>


<html>
<head>
<title>ϵͳ��¼</title>
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
		<div align="center"><font color=white> ��˾�칫��Ϣ����ϵͳ->��¼ҳ�� </font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="./html/home.jsp"><font color="#104DAD">������һվ��</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href="help.jsp"><font color="#104DAD">ϵͳʹ��˵��</font></a></td>
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
		<div align="center"><%if (!TheMessage.equals("��¼���ɹ�����¼�����������޷�����")) {%>
		<form name="form" method="post" action="login.jsp">
		<p><font color="#3466BB">�û�</font> <input class=itm name=UserName
			size=15></p>
		<p><font color="#3466BB">����</font> <input class=itm name=Password
			size=15 type=password> <br>
		<br>
		<input type="submit" name="Login" value="��¼"
			style="border: 1px solid #B6CAEB; background-color: #3466BB; color: #FFFFFF">
		<input type="reset" name="Reset" value="����"
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
