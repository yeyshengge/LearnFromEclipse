<%@ page contentType="text/html; charset=gb2312" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>
<%@ page import="cn.edu.buaa.nlsde.md5.MD5"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
String temp = "";
Hashtable HTThisUser = new Hashtable();
//�ж��û��Ƿ��¼�Լ�����ϵͳ����Ա���
if (session.getAttribute("ID") == null
	|| session.getAttribute("IsSystemManager").equals("False")) {
	response.sendRedirect("../login.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
ResultSet RSThisUser =
	stmt.executeQuery(
		"select * from PSLogins where LoginID= '"
			+ session.getAttribute("temp")
			+ "'");
while (RSThisUser.next()) {
	HTThisUser.put("LoginID", RSThisUser.getString(2));
	HTThisUser.put("Name", RSThisUser.getString(3));
	HTThisUser.put("Password", RSThisUser.getString(4));
	HTThisUser.put("EmailAddress", RSThisUser.getString(5));
	HTThisUser.put("Department", RSThisUser.getString(6));
	HTThisUser.put("Position", RSThisUser.getString(7));
	HTThisUser.put("InternalPhone", RSThisUser.getString(8));
	HTThisUser.put("HomePhone", RSThisUser.getString(9));
	HTThisUser.put("MobilePhone", RSThisUser.getString(10));
	HTThisUser.put("MSN", RSThisUser.getString(11));
	HTThisUser.put("HomeAddress", RSThisUser.getString(12));
	HTThisUser.put("IsSystemManager", RSThisUser.getString(13));
	HTThisUser.put("Birthday", RSThisUser.getString(14));
	HTThisUser.put("IsFinancialManager", RSThisUser.getString(15));
}
//�޸�ĳ���û���Ϣ
if (request.getParameter("Modify") != null) {
	//У���û�������
	if (request.getParameter("LoginID").trim().equals("")
		|| request.getParameter("Name").trim().equals("")
		|| request.getParameter("Password").trim().equals("")) {
		TheMessage = "�û���¼�������������벻��Ϊ��";
	}
	else {
		stmt.executeUpdate(
			"update PSLogins set EmailAddress='"
				+ request.getParameter("EmailAddress")
				+ "',Department='"
				+ request.getParameter("Department")
				+ "',Position='"
				+ request.getParameter("Position")
				+ "',InternalPhone='"
				+ request.getParameter("InternalPhone")
				+ "',HomePhone='"
				+ request.getParameter("HomePhone")
				+ "',MobilePhone='"
				+ request.getParameter("MobilePhone")
				+ "',MSN='"
				+ request.getParameter("MSN")
				+ "',HomeAddress='"
				+ request.getParameter("HomeAddress")
				+ "',IsSystemManager='"
				+ request.getParameter("IsSystemManager")
				+ "',Birthday='"
				+ request.getParameter("BirthdayYear")
				+ "-"
				+ request.getParameter("BirthdayMonth")
				+ "-"
				+ request.getParameter("BirthdayDay")
				+ "',IsFinancialManager='"
				+ request.getParameter("IsFinancialManager")
				+ "' Where LoginID='"
				+ request.getParameter("LoginID")
				+ "'");
		RSThisUser =
			stmt.executeQuery(
				"select * from PSLogins where LoginID= '"
					+ session.getAttribute("temp")
					+ "' ");
		while (RSThisUser.next()) {
			HTThisUser.put("LoginID", RSThisUser.getString(2));
			HTThisUser.put("Name", RSThisUser.getString(3));
			HTThisUser.put("Password", RSThisUser.getString(4));
			HTThisUser.put("EmailAddress", RSThisUser.getString(5));
			HTThisUser.put("Department", RSThisUser.getString(6));
			HTThisUser.put("Position", RSThisUser.getString(7));
			HTThisUser.put("InternalPhone", RSThisUser.getString(8));
			HTThisUser.put("HomePhone", RSThisUser.getString(9));
			HTThisUser.put("MobilePhone", RSThisUser.getString(10));
			HTThisUser.put("MSN", RSThisUser.getString(11));
			HTThisUser.put("HomeAddress", RSThisUser.getString(12));
			HTThisUser.put(
				"IsSystemManager",
				RSThisUser.getString(13));
			HTThisUser.put("Birthday", RSThisUser.getString(14));
			HTThisUser.put(
				"IsFinancialManager",
				RSThisUser.getString(15));
		}
		TheMessage = "���û���Ϣ�Ѿ��޸ĳɹ�";
	}
}
else {
	TheMessage = "���������޸Ĵ��û���Ϣ";
}
String Birthday = (String)HTThisUser.get("Birthday");
%>




<HTML>
<HEAD>
<TITLE>Employee Email Blast</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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

<table WIDTH=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>
	<tr>
		<td colspan=3>
		<div align="center"><font color=white>��˾�칫��Ϣ����ϵͳ->Ա����Ϣ��ѯ->ϵͳ����Աѡ��->�޸�ĳ��Ա����Ϣ[��ǰ�û�-
		<%=session.getAttribute("Name")%> ]</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="../html/home.jsp"><font color="#164DA8">����ϵͳ��ҳ</font></a></td>
		<td align=center><font color="#164DA8"><%=TheMessage%></FONT></td>
		<td align=right><a href="systemmanager.jsp"><font color="#164DA8">������һ����ҳ</font></a></td>
	</tr>
</table>
<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="13"><img src=".././image/banner2.jpg" width="800"
			height="12"></td>
	</tr>
</table>
<br>

<FORM ACTION="modifyuserinformation.jsp" METHOD=POST>
<TABLE CELLPADDING=1 CELLSPACING=1 BORDER=1 bordercolor="#164DA8"
	WIDTH=800 align=center>
	<TR VALIGN="middle" ALIGN="center">
		<TD WIDTH=30% bgcolor=#B5C7EF><img src="../image/employee1.jpg"></td>
		<td><br>
		<table CELLPADDING=0 CELLSPACING=1 BORDER=1 align=center width=100%>
			<tr>
				<td width=25%><font color="#164DA8">��¼��</font></td>
				<td><INPUT TYPE="text" NAME="LoginID"
					VALUE="<%=HTThisUser.get("LoginID")%>" SIZE=51 MAXLENGTH=50
					readonly="true"></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">����</font></td>
				<td><INPUT TYPE="text" NAME="Name"
					VALUE="<%=HTThisUser.get("Name")%>" SIZE=51 MAXLENGTH=50
					readonly="true"></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">����</font></td>
				<td><INPUT TYPE="password" NAME="Password" VALUE="initpassword"
					SIZE=51 MAXLENGTH=50 readonly="true"></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">����</font></td>
				<td><SELECT NAME="Department" size=1 width=10>
					<option value="<%=HTThisUser.get("Department")%>"><%=HTThisUser.get("Department")%></option>
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
				<td width=25%><font color="#164DA8">ְλ</font></td>
				<td><select name="Position" size=1>
					<option value="<%=HTThisUser.get("Position")%>"><%=HTThisUser.get("Position")%></option>
					<option value="��ͨ">��ͨ</option>
					<option value="����">����</option>
					<option value="����">����</option>
				</select></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�����ʼ���ַ</font></td>
				<td><INPUT TYPE="text" NAME="EmailAddress"
					VALUE="<%=HTThisUser.get("EmailAddress")%>" SIZE=51 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�ڲ��ֻ��绰</font></td>
				<td><INPUT TYPE="text" NAME="InternalPhone"
					VALUE="<%=HTThisUser.get("InternalPhone")%>" SIZE=51 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�ƶ��绰</font></td>
				<td><INPUT TYPE="text" NAME="MobilePhone"
					VALUE="<%=HTThisUser.get("MobilePhone")%>" SIZE=51 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">��ͥ�绰</font></td>
				<td><INPUT TYPE="text" NAME="HomePhone"
					VALUE="<%=HTThisUser.get("HomePhone")%>" SIZE=51 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">MSN</font></td>
				<td><INPUT TYPE="text" NAME="MSN" VALUE="<%=HTThisUser.get("MSN")%>"
					SIZE=51 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">��ͥסַ</font></td>
				<td><INPUT TYPE="text" NAME="HomeAddress"
					VALUE="<%=HTThisUser.get("HomeAddress")%>" SIZE=51 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�Ƿ�ϵͳ����Ա</font></td>
				<td><select name="IsSystemManager" size=1>
					<option value="<%=HTThisUser.get("IsSystemManager")%>"><%=HTThisUser.get("IsSystemManager")%></option>
					<option value="False">False</option>
					<option value="True">True</option>
				</select></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�Ƿ�������Ա</font></td>
				<td><select name="IsFinancialManager" size=1>
					<option value="<%=HTThisUser.get("IsFinancialManager")%>"><%=HTThisUser.get("IsFinancialManager")%></option>
					<option value="False">False</option>
					<option value="True">True</option>
				</select></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">����</font></td>
				<td><select name="BirthdayYear" size=1>
					<%int YearCounter = new Integer(Birthday.substring(0, 4)).intValue();%>
					<option value="<%=YearCounter%>"><%=YearCounter%></option>
					<%for (YearCounter = 2000; YearCounter >= 1900; YearCounter--) {%>
					<OPTION VALUE="<%=YearCounter%>"><%=YearCounter%></OPTION>
					<%}%>
				</select> �� <select name="BirthdayMonth" size=1>
					<%int MonthCounter = new Integer(Birthday.substring(5, 7)).intValue();%>
					<option value="<%=MonthCounter%>"><%=MonthCounter%></option>
					<%for (MonthCounter = 1; MonthCounter <= 12; MonthCounter++) {%>
					<OPTION VALUE="<%=MonthCounter%>"><%=MonthCounter%></OPTION>
					<%}%>
				</select> �� <select name="BirthdayDay" size=1>
					<%int DayCounter = new Integer(Birthday.substring(8, 10)).intValue();%>
					<option value="<%=DayCounter%>"><%=DayCounter%></option>
					<%for (DayCounter = 1; DayCounter <= 31; DayCounter++) {%>
					<OPTION VALUE="<%=DayCounter%>"><%=DayCounter%></OPTION>
					<%}%>
				</select> ��</td>
			</tr>
		</table>
		<br>
		</td>
	</TR>
</table>

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=1 WIDTH=800 align=center>
	<TR VALIGN="top" ALIGN="center">
		<TD WIDTH=100% align=center><INPUT TYPE="submit" NAME="Modify"
			VALUE="�޸��û���Ϣ"
			style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
		</TD>
	</TR>
</table>

</FORM>

</body>
</html>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
