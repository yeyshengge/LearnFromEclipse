<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>
<%@ page import="cn.edu.buaa.nlsde.md5.MD5"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
String temp = "";
//�ж��û��Ƿ��¼�Լ�����ϵͳ����Ա���
if (session.getAttribute("ID") == null
	|| session.getAttribute("IsSystemManager").equals("false")) {
	response.sendRedirect("../login.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
ResultSet RSDepartments =
	stmt.executeQuery(
		"select DepartmentName from Departments order by DepartmentName");
//������û�
if (request.getParameter("Add") != null) {
	String TheLoginID = request.getParameter("LoginID");
	String TheName = request.getParameter("Name");
	String TheEmailAddress = request.getParameter("EmailAddress");
	String ThePassword = request.getParameter("Password");
	String TheDepartment = request.getParameter("Department");
	String ThePosition = request.getParameter("Position");
	String TheInternalPhone = request.getParameter("InternalPhone");
	String TheHomePhone = request.getParameter("HomePhone");
	String TheMobilePhone = request.getParameter("MobilePhone");
	String TheMSN = request.getParameter("MSN");
	String TheHomeAddress = request.getParameter("HomeAddress");
	String TheIsSystemManager =
		request.getParameter("IsSystemManager");
	String TheBirthday =
		request.getParameter("BirthdayYear")
			+ "-"
			+ request.getParameter("BirthdayMonth")
			+ "-"
			+ request.getParameter("BirthdayDay");
	String TheIsFinancialManager =
		request.getParameter("IsFinancialManager");
	//���û��������У�飬�ϸ���������û���Ϣ
	if (ThePassword.trim().equals("")
		|| TheName.trim().equals("")
		|| TheLoginID.trim().equals("")) {
		TheMessage = "��¼�������������벻��Ϊ�գ��޷�������û�";
	}
	else {
		Statement stmt2 = conn.createStatement();
		stmt2.executeUpdate(
			"insert into PSLogins (LoginID, Name, Password, EmailAddress, "
				+ "Department, Position, Birthday, HomePhone, MSN, HomeAddress, "
				+ "InternalPhone, MobilePhone,IsSystemManager,IsFinancialManager) values ('"
				+ TheLoginID
				+ "','"
				+ TheName
				+ "','"
				+ new MD5().getMD5ofStr(ThePassword)
				+ "','"
				+ TheEmailAddress
				+ "','"
				+ TheDepartment
				+ "','"
				+ ThePosition
				+ "','"
				+ TheBirthday
				+ "','"
				+ TheHomePhone
				+ "','"
				+ TheMSN
				+ "','"
				+ TheHomeAddress
				+ "','"
				+ TheInternalPhone
				+ "','"
				+ TheMobilePhone
				+ "','"
				+ TheIsSystemManager
				+ "','"
				+ TheIsFinancialManager
				+ "')");
		TheMessage = "���û���ӳɹ�,��������";
	}
}
else {
	TheMessage = "��������������û�";
}
%>



<HEAD>
<TITLE>������û�</TITLE>
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
		<div align="center"><font color=white>
		��˾�칫��Ϣ����ϵͳ->Ա����Ϣ��ѯ->ϵͳ����Աѡ��->�������û�[��ǰ�û�- <%=session.getAttribute("Name")%>
		] </FONT></div>
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
<FORM ACTION="addnewuser.jsp" METHOD=POST>
<TABLE CELLPADDING=1 CELLSPACING=1 BORDER=1 bordercolor="#164DA8"
	WIDTH=800 align=center>
	<TR VALIGN="middle" ALIGN="center">
		<TD WIDTH=30% bgcolor=#B5C7EF><img src="../image/employee1.jpg"></td>
		<td><br>
		<table CELLPADDING=0 CELLSPACING=1 BORDER=1 align=center width=100%>
			<tr>
				<td width=25%><font color="#164DA8">��¼��</font></td>
				<td><INPUT TYPE="text" NAME="LoginID" VALUE="" SIZE=50 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">����</font></td>
				<td><INPUT TYPE="text" NAME="Name" VALUE="" SIZE=50 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">����������</font></td>
				<td><INPUT TYPE="text" NAME="Password" VALUE="" SIZE=50 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">����</font></td>
				<td><SELECT NAME="Department" size=1 width=10>
					<%while (RSDepartments.next()) {
	temp = RSDepartments.getString("DepartmentName");%>
					<OPTION VALUE="<%=temp%>"><%=temp%></OPTION>
					<%}%>
				</SELECT></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">ְλ</font></td>
				<td><select name="Position" size=1>
					<option value="��ͨ">��ͨ</option>
					<option value="����">����</option>
					<option value="����">����</option>
				</select></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�����ʼ���ַ</font></td>
				<td><INPUT TYPE="text" NAME="EmailAddress" VALUE="" SIZE=50
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�ڲ��ֻ��绰</font></td>
				<td><INPUT TYPE="text" NAME="InternalPhone" VALUE="" SIZE=50
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�ƶ��绰</font></td>
				<td><INPUT TYPE="text" NAME="MobilePhone" VALUE="" SIZE=50
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">��ͥ�绰</font></td>
				<td><INPUT TYPE="text" NAME="HomePhone" VALUE="" SIZE=50
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">MSN</font></td>
				<td><INPUT TYPE="text" NAME="MSN" VALUE="" SIZE=50 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">��ͥסַ</font></td>
				<td><INPUT TYPE="text" NAME="HomeAddress" VALUE="" SIZE=50
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�Ƿ�ϵͳ����Ա</font></td>
				<td><select name="IsSystemManager" size=1>
					<option value="False">��</option>
					<option value="True">��</option>
				</select></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">����</font></td>
				<td><select name="BirthdayYear" size=1>
					<%for (int YearCounter = 2000; YearCounter >= 1900; YearCounter--) {%>
					<OPTION VALUE="<%=YearCounter%>"><%=YearCounter%></OPTION>
					<%}%>
				</select> �� <select name="BirthdayMonth" size=1>
					<%for (int MonthCounter = 1; MonthCounter <= 12; MonthCounter++) {%>
					<OPTION VALUE="<%=MonthCounter%>"><%=MonthCounter%></OPTION>
					<%}%>
				</select> �� <select name="BirthdayDay" size=1>
					<%for (int DayCounter = 1; DayCounter <= 31; DayCounter++) {%>
					<OPTION VALUE="<%=DayCounter%>"><%=DayCounter%></OPTION>
					<%}%>
				</select> ��</td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�Ƿ�������Ա</font></td>
				<td><select name="IsFinancialManager" size=1>
					<option value="False">��</option>
					<option value="True">��</option>
				</select></td>
			</tr>
		</table>
		<br>
		</td>
	</TR>
</table>

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=1 WIDTH=800 align=center>
	<TR VALIGN="top" ALIGN="center">
		<TD WIDTH=100% align=center><INPUT TYPE="submit" NAME="Add"
			VALUE="������û���Ϣ"
			style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB"></TD>
	</TR>
</table>

</form>
</body>
</html>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
