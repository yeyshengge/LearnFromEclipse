<%@ page contentType="text/html; charset=gb2312" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%String TheMessage = "";
//�ж��û��Ƿ��¼
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
ResultSet RSPublicMessage =
	stmt.executeQuery(
		" select * from MessageBoard where MessageType = '����֪ͨ'  and GETDATE()-MessageValidTime <= MessageSendDate order by MessageSendDate DESC");
TheMessage = "��ѡ����Ҫ������ڲ���Ϣ��������ģ��";
%>

<HTML>
<HEAD>
<TITLE>�ڲ���Ϣ������ϵͳ</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</HEAD>


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
		<div align="center"><font color=white>��˾�칫��Ϣ����ϵͳ->�ڲ���Ϣ����ϵͳ[��ǰ�û�-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href=".././html/home.jsp"><font color="#104DAD">����ϵͳ��ҳ</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href=".././html/home.jsp"><font color="#104DAD">������һ����ҳ</font></a></td>
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
<br>

<TABLE CELLPADDING=1 CELLSPACING=2 BORDER=1 bordercolor="#164DA8"
	WIDTH=800 align=center>
	<TR VALIGN="middle" ALIGN="center">
		<TD WIDTH=35% bgcolor=#B5C7EF><img src="../image/messageboard1.jpg"></td>
		<td>
		<table>
			<tr height=30>
				<td><font color="#104DAD">�ڲ���Ϣ������ϵͳ</font> -><a
					href="messageboard.jsp"><font color="#104DAD">֪ͨ������</font></a></td>
			</tr>
			<tr height=30>
				<td><font color="#104DAD">�ڲ���Ϣ������ϵͳ</font> -><a
					href="suggestionbox.jsp"><font color="#104DAD">�ڲ������</font></a></td>
			</tr>
			<tr height=30>
				<td><font color="#104DAD">�ڲ���Ϣ������ϵͳ</font> -><a href="voting.jsp"><font
					color="#104DAD">�ڲ�ͶƱվ</font></a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<FORM ACTION="messageboard.jsp" METHOD=POST>
<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="3" cellspacing="0">
	<tr>
		<td><br>
		<table WIDTH=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
			align=center>
			<tr>
				<td colspan=3 height=1><font color=white>���չ�˾�����¹���֪ͨ</font></td>
			</tr>
			<tr bgcolor=white>
				<td width=15% align=left>֪ͨ��������</td>
				<td width=50% align=left>֪ͨ����</td>
				<td width=10% align=left>֪ͨ����</td>
				<td align=left>֪ͨ������</td>
				<td align=left>��Ч����</td>
			</tr>
			<%String MessageSendDate = "";
String MessageContent = "";
String MessageType = "";
String MessageSender = "";
int MessageValidTime = 0;
while (RSPublicMessage.next()) {
	MessageContent = RSPublicMessage.getString("MessageContent");
	MessageType = RSPublicMessage.getString("MessageType");
	MessageSender = RSPublicMessage.getString("MessageSender");
	MessageSendDate =
		RSPublicMessage.getString("MessageSendDate").substring(0, 10);
	MessageValidTime = RSPublicMessage.getInt("MessageValidTime");%>
			<TR bgcolor=white VALIGN="top" ALIGN="left">
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

		</td>
	</tr>
</table>
</FORM>

</BODY>
</HTML>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
