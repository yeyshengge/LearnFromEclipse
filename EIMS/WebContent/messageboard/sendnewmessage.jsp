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
//�ж��û��Ƿ��¼
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//�û�ѡ���˷�����֪ͨ��ť
if (request.getParameter("SendNewMessage") != null) {
	//�ж�֪ͨ���͵��Ķ���
	if (request.getParameter("SendMessageTo").equals("Public")) {
		TheMessageType = "����֪ͨ";
	}
	else if (
		request.getParameter("SendMessageTo").equals("Department")) {
		TheMessageType = request.getParameter("DepartmentName");
	}
	else if (
		request.getParameter("SendMessageTo").equals("Person")) {
		TheMessageType = request.getParameter("PersonName");
	}
	//У��֪ͨ������
	if (request.getParameter("MessageContent").trim().equals("")) {
		TheMessage = "֪ͨ���ݲ���Ϊ��,�޷�����֪ͨ";
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
		TheMessage = "��֪ͨ�ѳɹ�����";
	}
}
else {
	TheMessage = "����������д��Ҫ���͵�֪ͨ������";
}
%>

<HTML>
<HEAD>
<TITLE>�ڲ���Ϣ����ϵͳ</TITLE>
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
		��˾�칫��Ϣ����ϵͳ->�ڲ���Ϣ����->֪ͨ������->������֪ͨ[��ǰ�û�-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href=".././html/home.jsp"><font color="#104DAD">����ϵͳ��ҳ</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href="messageboard.jsp"><font color="#104DAD">������һ����ҳ</font></a></td>
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
				<td><font color="#164DA8">��֪ͨҪ���͸�</font></td>
				<td>

				<table CELLPADDING=1 CELLSPACING=1 BORDER=1 align=center width=100%>
					<tr>
						<td width=35%><INPUT TYPE="radio" CHECKED NAME="SendMessageTo"
							VALUE="Public"><font color="#164DA8">����Ա��</font></td>
						<td>;</td>
					</tr>
					<tr>
						<td><INPUT TYPE="radio" NAME="SendMessageTo" VALUE="Department"><font
							color="#164DA8">ĳ������</font></td>
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
							color="#164DA8">ĳ��Ա��</font></td>
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
				<td width=35%><font color="#164DA8">�����ұ���д֪ͨ����</font></td>
				<td><TEXTAREA NAME="MessageContent" ROWS=10 COLS=45></TEXTAREA></td>
			</tr>
			<tr>
				<td><font color="#164DA8">��֪ͨ��Ч����</font></td>
				<td><select name=MessageValidTime>
					<%for (int ccounter = 1; ccounter <= 31; ccounter++) {%>
					<OPTION VALUE=<%=ccounter%>><%=ccounter%>��</OPTION>
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
			VALUE="������֪ͨ"
			style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
		</TD>
	</tr>
</table>


</FORM>
</BODY>
</HTML>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
