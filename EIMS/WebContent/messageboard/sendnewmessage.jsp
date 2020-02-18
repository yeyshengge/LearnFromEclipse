<%@ page contentType="text/html; charset=gb2312" language="java"  %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%request.setCharacterEncoding("GB2312");
String TheMessageType = "";
String TheMessage = "";
String temp = "";
Calendar cal = Calendar.getInstance();
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String Time = format.format(cal.getTime());
format = new SimpleDateFormat("yyyy-MM-dd");
String Date = format.format(cal.getTime());
//判断用户是否登录
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//连接系统数据库
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//用户选择了发送新通知按钮
if (request.getParameter("SendNewMessage") != null) {
	//判断通知发送到的对象
	if (request.getParameter("SendMessageTo").equals("Public")) {
		TheMessageType = "公共通知";
	}
	else if (
		request.getParameter("SendMessageTo").equals("Department")) {
		TheMessageType = request.getParameter("DepartmentName");
	}
	else if (
		request.getParameter("SendMessageTo").equals("Person")) {
		TheMessageType = request.getParameter("PersonName");
	}
	//校验通知的内容
	if (request.getParameter("MessageContent").trim().equals("")) {
		TheMessage = "通知内容不能为空,无法发送通知";
	}
	else {
		stmt.executeUpdate(
			" insert into MessageBoard (MessageContent, MessageType, MessageSender, MessageSendDate, MessageSendTime, MessageValidTime) values ('"
				+ request.getParameter("MessageContent")
				+ "','"
				+ TheMessageType
				+ "','"
				+ session.getAttribute("Name")
				+ "','"
				+ Date
				+ "','"
				+ Time
				+ "',"
				+ request.getParameter("MessageValidTime")
				+ ")");
		TheMessage = "新通知已成功发送";
	}
}
else {
	TheMessage = "请在下面填写您要发送的通知的内容";
}
%>

<HTML>
<HEAD>
<TITLE>内部信息交流系统</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</HEAD>
<body>

<table width=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>
	<tr bgcolor=white>
		<td valign=middle><img src="../image/jsplogo.jpg" width=796 height=100></td>
	</tr>
</table>
<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="13"><img src=".././image/banner2.jpg" width="800"
			height="12"></td>
	</tr>
</table>
<table width=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>
	<tr>
		<td colspan=3>
		<div align="center"><font color=white>
		公司办公信息管理系统->内部信息交流->通知公告牌->发送新通知[当前用户-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href=".././html/home.jsp"><font color="#104DAD">返回系统主页</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href="messageboard.jsp"><font color="#104DAD">返回上一级网页</font></a></td>
	</tr>
</table>
<table width=800 border="0" bordercolor="#164DA8" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="13"><img src=".././image/banner2.jpg" width="100%"
			height="12"></td>
	</tr>
</table>

<br>

<form action="sendnewmessage.jsp" method=post>
<TABLE CELLPADDING=1 CELLSPACING=2 BORDER=1 bordercolor="#164DA8"
	WIDTH=800 align=center>
	<TR VALIGN="middle" ALIGN="center">
		<TD WIDTH=35% bgcolor=#B5C7EF><img src="../image/messageboard1.jpg"></td>
		<td>

		<table border=1 cellspacing=1 cellpadding=1 width=100%>
			<tr>
				<td><font color="#164DA8">此通知要发送给</font></td>
				<td>

				<table CELLPADDING=1 CELLSPACING=1 BORDER=1 align=center width=100%>
					<tr>
						<td width=35%><INPUT TYPE="radio" CHECKED NAME="SendMessageTo"
							VALUE="Public"><font color="#164DA8">所有员工</font></td>
						<td>;</td>
					</tr>
					<tr>
						<td><INPUT TYPE="radio" NAME="SendMessageTo" VALUE="Department"><font
							color="#164DA8">某个部门</font></td>
						<td><SELECT NAME="DepartmentName">
							<%ResultSet RSDepartments =
	stmt.executeQuery(
		"select  DepartmentName from Departments order by DepartmentName");
while (RSDepartments.next()) {
	temp = RSDepartments.getString("DepartmentName");%>
							<OPTION VALUE="<%=temp%>"><%=temp%></OPTION>
							<%}%>
						</SELECT></td>
					</tr>
					<tr>
						<td><INPUT TYPE="radio" NAME="SendMessageTo" VALUE="Person"><font
							color="#164DA8">某个员工</font></td>
						<td><SELECT NAME="PersonName">
							<%ResultSet RSPersons =
	stmt.executeQuery("select Name from PSLogins order by Name");
while (RSPersons.next()) {
	temp = RSPersons.getString("Name");%>
							<OPTION VALUE="<%=temp%>"><%=temp%></OPTION>
							<%}%>
						</SELECT></td>
					</tr>
				</table>

				</td>
			</tr>

			<tr>
				<td width=35%><font color="#164DA8">请在右边填写通知内容</font></td>
				<td><TEXTAREA NAME="MessageContent" ROWS=10 COLS=45></TEXTAREA></td>
			</tr>
			<tr>
				<td><font color="#164DA8">此通知有效天数</font></td>
				<td><select name=MessageValidTime>
					<%for (int ccounter = 1; ccounter <= 31; ccounter++) {%>
					<OPTION VALUE=<%=ccounter%>><%=ccounter%>天</OPTION>
					<%}%>
				</select></td>
			</tr>
		</table>

		</td>
	</TR>
</table>

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=1 WIDTH=800 align=center>
	<TR VALIGN="top" ALIGN="center">
		<TD WIDTH=100% align=center><INPUT TYPE="submit" NAME="SendNewMessage"
			VALUE="发送新通知"
			style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
		</TD>
	</tr>
</table>


</FORM>
</BODY>
</HTML>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
