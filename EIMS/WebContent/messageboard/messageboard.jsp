<%@ page contentType="text/html; charset=gb2312" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
int MessageID = 0;
String MessageSendDate = "";
String MessageContent = "";
String MessageType = "";
String MessageSender = "";
int MessageValidTime = 0;
//�ж��û��Ƿ��¼
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
boolean Warning = false;
//�û�ѡ������֪ͨ
if (request.getParameter("SendNewMessage") != null) {
	response.sendRedirect("sendnewmessage.jsp");
}
//�û�ѡ��ɾ��ĳ��֪ͨ
else if (request.getParameter("DeleteThisMessage") != null) {
	if (request.getParameter("CheckMessage") != null) {
		ResultSet RSThisMessage =
			stmt.executeQuery(
				"select * from MessageBoard where MessageID="
					+ request.getParameter("CheckMessage"));
		if (session.getAttribute("IsSystemManager").equals("True")) {
			stmt.executeUpdate(
				"delete from MessageBoard where MessageID = "
					+ request.getParameter("CheckMessage"));
			TheMessage = "����֪ͨ��ɾ��";
		}
		else if (
			RSThisMessage.getString("MessageSender").equals(
				session.getAttribute("Name"))) {
			stmt.executeUpdate(
				"delete from MessageBoard where MessageID = '"
					+ request.getParameter("CheckMessage")
					+ "' ");
			TheMessage = "����֪ͨ��ɾ��";
		}
		//else if RSThisMessage("MessageType")=Session("Name") then
		//conn.Execute   "delete from MessageBoard where MessageID = '" _
		//& request.getParameter("CheckMessage") & "' "
		//TheMessage ="����֪ͨ��ɾ��"
		else {
			TheMessage = "������ϵͳ����Ա,Ҳ���Ǵ���֪ͨ�ķ�����,��Ȩɾ������֪ͨ";
			Warning = true;
		}
	}
	else {
		TheMessage = "�ճ�֪ͨ����";
	}
}
//�û�ѡ���޸�ĳ��֪ͨ
else if (request.getParameter("ModifyThisMessage") != null) {
	if (request.getParameter("CheckMessage") != null) {
		ResultSet RSThisMessage =
			stmt.executeQuery(
				"select * from MessageBoard where MessageID="
					+ request.getParameter("CheckMessage"));
		int messageID = 0;
		String messageSender = "";
		while (RSThisMessage.next()) {
			messageID = RSThisMessage.getInt("MessageID");
			messageSender = RSThisMessage.getString("MessageSender");
			if (messageSender.equals(session.getAttribute("Name"))) {
				session.setAttribute(
					"MessageID",
					new Integer(messageID));
				response.sendRedirect("modifymessage.jsp");
			}
			else {
				TheMessage = "�����Ǵ���֪ͨ�ķ�����,��Ȩ�޸Ĵ���֪ͨ";
				Warning = true;
			}
		}
	}
	else {
		TheMessage = "�ճ�֪ͨ����";
	}
}
//ϵͳ����Ա�������֪ͨ
else if (request.getParameter("ClearMessage") != null) {
	if (session.getAttribute("IsSystemManager").equals("True")) {
		stmt.executeUpdate(
			"delete from MessageBoard where GETDATE() - MessageValidTime > MessageSendDate");
	}
	else {
		TheMessage = "������ϵͳ����Ա,���ܽ��д������";
		Warning = true;
	}
}
else {
	TheMessage = "�ճ�֪ͨ����";
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
		��˾�칫��Ϣ����ϵͳ->�ڲ���Ϣ����->֪ͨ������&nbsp[��ǰ�û�-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href=".././html/home.jsp"><font color="#104DAD">����ϵͳ��ҳ</font></a></td>
		<td align=center><%if (Warning == false) {%> <font color="#104DAD"><%=TheMessage%></FONT>
		<%}
else {%> <font color=Red><%=TheMessage%></font> <%}%></td>
		<td align=right><a href="communication.jsp"><font color="#104DAD">������һ����ҳ</font></a></td>
	</tr>
</table>

<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="10" colspan="4" valign="top" bgcolor="#FFFFFF">
		<table width="100%" border="0" height="13" cellspacing="0"
			cellpadding="0" mm_noconvert="TRUE">
			<tr>
				<td height="13"><img src=".././image/banner2.jpg" width="800"
					height="12"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<FORM ACTION="messageboard.jsp" METHOD=POST>
<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="3" cellspacing="0">
	<tr>
		<td>
		<table WIDTH=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
			align=center>
			<tr>
				<td colspan=3 height=1><font color=white>�����������¹���֪ͨ</font></td>
			</tr>
			<tr bgcolor=white>
				<td width=30 align=left>ѡ��</td>
				<td width=15% align=left>֪ͨ��������</td>
				<td width=50% align=left>֪ͨ����</td>
				<td width=10% align=left>֪ͨ����</td>
				<td align=left>֪ͨ������</td>
				<td align=left>��Ч����</td>
			</tr>
			<%ResultSet RSPublicMessage =
	stmt.executeQuery(
		" select * from MessageBoard where MessageType = '����֪ͨ' and GETDATE() - MessageValidTime <= MessageSendDate order by MessageSendDate");
while (RSPublicMessage.next()) {
	MessageID = RSPublicMessage.getInt("MessageID");
	MessageContent = RSPublicMessage.getString("MessageContent");
	MessageType = RSPublicMessage.getString("MessageType");
	MessageSender = RSPublicMessage.getString("MessageSender");
	MessageSendDate =
		RSPublicMessage.getString("MessageSendDate").substring(0, 10);
	MessageValidTime = RSPublicMessage.getInt("MessageValidTime");
%>
			<TR bgcolor=white VALIGN="top" ALIGN="left">
				<td align=left><input type=radio name=CheckMessage
					value=<%=MessageID%>></td>
				<TD><font face=arial><%=MessageSendDate%></font></TD>
				<TD><font face=arial><%=MessageContent%></font></TD>
				<TD HEIGHT=21><font face=arial><%=MessageType%></font></TD>
				<TD HEIGHT=21><font face=arial><%=MessageSender%></font></TD>
				<TD HEIGHT=21><font face=arial><%=MessageValidTime%></font></TD>
			</TR>
			<%}%>
		</table>
		<table width="800" border="0" bordercolor="#164DA8" align="center"
			cellpadding="0" cellspacing="0">
			<tr>
				<td height="13"><img src=".././image/banner2.jpg" width="800"
					height="12"></td>
			</tr>
		</table>

		<br>
		<table WIDTH=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
			align=center>
			<tr>
				<td colspan=3 height=1><font color=white>����<%=session.getAttribute("Department")%>�����²���֪ͨ</font></td>
			</tr>
			<tr bgcolor=white>
				<td width=30 align=left>ѡ��</td>
				<td width=15% align=left>֪ͨ��������</td>
				<td width=50% align=left>֪ͨ����</td>
				<td width=10% align=left>֪ͨ����</td>
				<td align=left>֪ͨ������</td>
				<td align=left>��Ч����</td>
			</tr>
			<%ResultSet RSDepartmentMessage =
	stmt.executeQuery(
		" select * from MessageBoard where MessageType = '"
			+ session.getAttribute("Department")
			+ "' and "
			+ "GETDATE() - MessageValidTime <= MessageSendDate order by MessageSendDate");
while (RSDepartmentMessage.next()) {
	MessageID = RSDepartmentMessage.getInt("MessageID");
	MessageContent = RSDepartmentMessage.getString("MessageContent");
	MessageType = RSDepartmentMessage.getString("MessageType");
	MessageSender = RSDepartmentMessage.getString("MessageSender");
	MessageSendDate =
		RSDepartmentMessage.getString("MessageSendDate").substring(
			0,
			10);
	MessageValidTime = RSDepartmentMessage.getInt("MessageValidTime");
%>
			<TR bgcolor=white VALIGN="top" ALIGN="left">
				<td align=left><input type=radio name=CheckMessage
					value=<%=MessageID%>></td>
				<TD><font face=arial><%=MessageSendDate%></font></TD>
				<TD><font face=arial><%=MessageContent%></font></TD>
				<TD HEIGHT=21><font face=arial><%=MessageType%></font></TD>
				<TD HEIGHT=21><font face=arial><%=MessageSender%></font></TD>
				<TD HEIGHT=21><font face=arial><%=MessageValidTime%></font></TD>
			</TR>
			<%}%>
		</table>
		<table width="800" border="0" bordercolor="#164DA8" align="center"
			cellpadding="0" cellspacing="0">
			<tr>
				<td height="13"><img src=".././image/banner2.jpg" width="800"
					height="12"></td>
			</tr>
		</table>

		<br>

		<table WIDTH=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
			align=center>
			<tr>
				<td colspan=3 height=1><font color=white>�����������¸���֪ͨ</font></td>
			</tr>
			<tr bgcolor=white>
				<td width=30 align=left>ѡ��</td>
				<td width=15% align=left>֪ͨ��������</td>
				<td width=50% align=left>֪ͨ����</td>
				<td width=10% align=left>֪ͨ������</td>
				<td align=left>֪ͨ������</td>
				<td align=left>��Ч����</td>
			</tr>
			<%ResultSet RSPrivateMessage =
	stmt.executeQuery(
		" select * from MessageBoard where MessageType= '"
			+ session.getAttribute("Name")
			+ "' and "
			+ "GETDATE() - MessageValidTime <= MessageSendDate order by MessageSendDate");
while (RSPrivateMessage.next()) {
	MessageID = RSPrivateMessage.getInt("MessageID");
	MessageContent = RSPrivateMessage.getString("MessageContent");
	MessageType = RSPrivateMessage.getString("MessageType");
	MessageSender = RSPrivateMessage.getString("MessageSender");
	MessageSendDate =
		RSPrivateMessage.getString("MessageSendDate").substring(
			0,
			10);
	MessageValidTime = RSPrivateMessage.getInt("MessageValidTime");
%>
			<TR bgcolor=white VALIGN="top" ALIGN="left">
				<td align=left><input type=radio name=CheckMessage
					value=<%=MessageID%>></td>
				<TD><font face=arial><%=MessageSendDate%></font></TD>
				<TD><font face=arial><%=MessageContent%></font></TD>
				<TD HEIGHT=21><font face=arial><%=MessageType%></font></TD>
				<TD HEIGHT=21><font face=arial><%=MessageSender%></font></TD>
				<TD HEIGHT=21><font face=arial><%=MessageValidTime%></font></TD>
			</TR>
			<%}%>
		</table>
		<table width="800" border="0" bordercolor="#164DA8" align="center"
			cellpadding="0" cellspacing="0">
			<tr>
				<td height="13"><img src=".././image/banner2.jpg" width="800"
					height="12"></td>
			</tr>
		</table>

		<table WIDTH=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
			align=center>
			<TR bgcolor=white VALIGN="top" ALIGN="center">

				<td><input type=submit name="ModifyThisMessage" value="�޸Ĵ���֪ͨ"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				<input type=submit name="DeleteThisMessage" value="ɾ������֪ͨ"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				<INPUT TYPE="submit" NAME="SendNewMessage" VALUE="������֪ͨ"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				<INPUT TYPE="submit" NAME="ClearMessage" VALUE="����Ա��չ���֪ͨ"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				</td>
			</tr>
		</table>
</table>
</FORM>
</BODY>
</HTML>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
