<%@ page contentType="text/html; charset=gb2312" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%String TheMessage = "";
String temp = "";
//�ж��û��Ƿ��¼�Լ��Ƿ���ϵͳ����Ա
if (session.getAttribute("ID") == null
	|| session.getAttribute("IsSystemManager").equals("False")) {
	response.sendRedirect("../login.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
ResultSet EmployeeInformation =
	stmt.executeQuery(
		" select * from PSLogins order by "
			+ session.getAttribute("SystemOrder"));
//������û���Ϣ
if (request.getParameter("Add") != null) {
	response.sendRedirect("addnewuser.jsp");
}
//ɾ��ĳ���û���Ϣ
else if (request.getParameter("Delete") != null) {
	if (request.getParameter("SelectWho") != null) {
		stmt.executeUpdate(
			"delete from PSLogins where LoginID = '"
				+ request.getParameter("SelectWho")
				+ "'");
		TheMessage = "��¼�ѱ�ɾ��";
		EmployeeInformation =
			stmt.executeQuery("select * from PSLogins order by Name");
	}
}
//�޸�ĳ���û���Ϣ
else if (request.getParameter("Modify") != null) {
	if (request.getParameter("SelectWho") != null) {
		session.setAttribute(
			"temp",
			request.getParameter("SelectWho"));
		response.sendRedirect("modifyuserinformation.jsp");
	}
}
else {
	TheMessage = "���������޸�Ա����Ϣ";
}
%>

<HTML>
<HEAD>
<TITLE>ϵͳ����Աҳ��</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../theme/Master.css" rel="stylesheet" type="text/css">
</HEAD>

<BODY BGCOLOR="">

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
<table WIDTH=100% border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>
	<tr>
		<td colspan=3>
		<div align="center"><font color=white>��˾�칫��Ϣ����ϵͳ->Ա����Ϣ��ѯ->ϵͳ����Աѡ��&nbsp[��ǰ�û�-
		<%=session.getAttribute("Name")%> ]</FONT></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="../html/home.jsp"><font color="#164DA8">����ϵͳ��ҳ</font></a></td>
		<td align=center><font color="#164DA8"><%=TheMessage%></FONT></td>
		<td align=right><a href="employeeinformation.jsp"><font
			color="#164DA8">������һ����ҳ</font></a></td>
	</tr>
</table>
<table width="100%" border="0" bordercolor="#164DA8" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="13"><img src=".././image/banner2.jpg" width="100%"
			height="12"></td>
	</tr>
</table>
<br>
<FORM ACTION="systemmanager.jsp" METHOD=POST class="little">
  <TABLE WIDTH=100% border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>
	<TR>
		<TD COLSPAN=14 align=center><font color=white>ȫ��Ա����Ϣ����</font></TD>
	</TR>
	<TR VALIGN="middle" ALIGN="center" bgcolor=white>
		<td>ѡ��</td>
		<td>��¼��</td>
		<td>����</td>
		<td>�����ʼ���ַ</td>
		<td>����</td>
		<td>ְλ</td>
		<td>�ڲ��ֻ�</td>
		<td>��ͥ�绰</td>
		<td>�ֻ�</td>
		<td>MSN</td>
		<td>��ͥסַ</td>
		<td>�Ƿ�ϵͳ����Ա</td>
		<td>����</td>
		<td>�Ƿ��������</td>
	</TR>
	<%while (EmployeeInformation.next()) {
	temp = EmployeeInformation.getString(2);
	out.println(
		"<tr bgcolor=white> <td align=center><input type=radio name=SelectWho value="
			+ temp
			+ "> </td> <td align=center><font face=arial>"
			+ temp
			+ "</font></td> <td align=center><font face=arial>"
			+ EmployeeInformation.getString(3)
			+ "</font></td> <td align=center><font face=arial>"
			+ EmployeeInformation.getString(5)
			+ "</font></td> <td align=center><font face=arial>"
			+ EmployeeInformation.getString(6)
			+ "</font></td> <td align=center><font face=arial>"
			+ EmployeeInformation.getString(7)
			+ "</font></td> <td align=center><font face=arial>"
			+ EmployeeInformation.getString(8)
			+ "</font></td> <td align=center><font face=arial>"
			+ EmployeeInformation.getString(9)
			+ "</font></td> <td align=center><font face=arial>"
			+ EmployeeInformation.getString(10)
			+ "</font></td> <td align=center><font face=arial>"
			+ EmployeeInformation.getString(11)
			+ "</font></td> <td align=center><font face=arial>"
			+ EmployeeInformation.getString(12)
			+ "</font></td> <td align=left><font face=arial>"
			+ EmployeeInformation.getString(13)
			+ "</font></td> <td align=center><font face=arial>"
			+ EmployeeInformation.getString(14).substring(0, 10)
			+ "</font></td> <td align=center><font face=arial>"
			+ EmployeeInformation.getString(15)
			+ "</font></td></tr>");
}%>
</TABLE>

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=1 WIDTH=100% align=center>
	<TR VALIGN="top" ALIGN="center">
		<TD WIDTH=100% align=center><INPUT TYPE="submit" NAME="Modify"
			VALUE="�޸Ĵ��û���Ϣ"
			style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
		<INPUT TYPE="submit" NAME="Delete" VALUE="ɾ�����û���Ϣ"
			style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
		<INPUT TYPE="submit" NAME="Add" VALUE="������û���Ϣ"
			style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB"></TD>
	</TR>
</table>
</FORM>

</body>
</html>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
