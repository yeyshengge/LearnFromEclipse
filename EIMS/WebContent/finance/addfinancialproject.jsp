<%@ page contentType="text/html; charset=gb2312" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
String TheFinancialProjectName = "";
String TheAddDate = "";
String TheFinancialManager = "";
String temp = "";
//�ж��û��Ƿ��¼
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//�ж��û��Ƿ���в������Ա���
if (session.getAttribute("IsFinancialManager").equals("False")) {
	response.sendRedirect("finance.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
boolean Warning = false;
//����²�����Ŀ
if (request.getParameter("AddProject") != null) {
	TheFinancialProjectName =
		request.getParameter("FinancialProjectName");
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	TheAddDate = format.format(cal.getTime());
	//У���û��Ƿ��ǲ����ŵ�����
	if (session.getAttribute("Department").equals("����")
		&& session.getAttribute("Position").equals("����")) {
		//���б���ѡ���²�����Ŀ�ĸ�����
		TheFinancialManager =
			request.getParameter("SelectFinancialManager");
		//У���û��������Ƿ�Ϻ�Ҫ��
		if (TheFinancialProjectName.trim().equals("")) {
			TheMessage = "������Ŀ���Ʋ���Ϊ�գ��������²�����Ŀ����";
			Warning = true;
		}
		else {
			//�����ݿ�����²�����Ŀ
			stmt.executeUpdate(
				"insert into FinancialProject (FinancialProjectName, AddDate, FinancialManager) values ('"
					+ TheFinancialProjectName
					+ "','"
					+ TheAddDate
					+ "','"
					+ TheFinancialManager
					+ "')");
			TheMessage = "������Ŀ���ύ�ɹ�������д�²�����Ŀ";
			Warning = false;
		}
	}
	else {
		TheMessage = "�����ǲ������ܣ���Ȩ��Ӳ�����Ŀ";
		Warning = true;
	}
}
//ɾ��ĳ��������Ŀ
else if (request.getParameter("DeleteProject") != null) {
	//�ж��û��Ƿ��ǲ���������
	if (session.getAttribute("Department").equals("����")
		&& session.getAttribute("Position").equals("����")) {
		stmt.executeUpdate(
			"delete from FinancialProject where FinancialProjectID="
				+ request.getParameter("RadioFinancialProject"));
		TheMessage = "���Ѿ�ɾ���˴˲�����Ŀ";
	}
	else {
		TheMessage = "�����ǲ������ܣ���Ȩɾ���˲�����Ŀ";
		Warning = true;
	}
}
else {
	TheMessage = "����������д�µĲ�����Ŀ";
}
%>



<HTML>
<HEAD>
<TITLE>��˾������Ϣ����ϵͳ</TITLE>
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
<table width=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>
	<tr>
		<td colspan=3>
		<div align="center"><font color=white>
		��˾�칫��Ϣ����ϵͳ->��˾������Ϣ����ϵͳ->��Ӳ����¼&nbsp->��Ӳ�����Ŀ[��ǰ�û�-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="../html/home.jsp"><font color="#104DAD">����ϵͳ��ҳ</font></a></td>
		<td align=center><%if (Warning == false) {%> <font color="#104DAD"><%=TheMessage%></FONT>
		<%}
else {%> <font color=Red><%=TheMessage%></font> <%}%></td>
		<td align=right><a href="addfinancialrecord.jsp"><font color="#104DAD">������һ����ҳ</font></a></td>
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



<FORM ACTION="addfinancialproject.jsp" METHOD=POST>

<TABLE CELLPADDING=1 CELLSPACING=2 BORDER=1 bordercolor="#164DA8"
	align=center>
	<TR VALIGN="middle" ALIGN="center">
		<TD bgcolor=#B5C7EF><img src="../image/finance1.jpg"></td>
		<td>
		<table CELLPADDING=1 CELLSPACING=2 BORDER=0 align=center
			bgcolor=#B5C7EF>
			<tr>
				<td>ѡ��</td>
				<td>������ĿID</td>
				<td>������Ŀ����</td>
				<td>�������</td>
				<td>��Ŀ����</td>
			</tr>
			<%ResultSet RSFinancialProjects =
	stmt.executeQuery(
		"select * from FinancialProject order by FinancialProjectName");
while (RSFinancialProjects.next()) {
	int index = RSFinancialProjects.getInt("FinancialProjectID");
	out.println(
		"<tr bgcolor=white><td><input type=radio name=RadioFinancialProject value="
			+ index
			+ "></td>");
	out.println("<td>" + index + "</td>");
	out.println(
		"<td>"
			+ RSFinancialProjects.getString("FinancialProjectName")
			+ "</td>");
	out.println(
		"<td>"
			+ RSFinancialProjects.getString("AddDate").substring(0, 10)
			+ "</td>");
	out.println(
		"<td>"
			+ RSFinancialProjects.getString("FinancialManager")
			+ "</td>");
}
%>
			<table>
				<tr>
					<td>
					<table CELLPADDING=1 CELLSPACING=1 BORDER=1 align=center>
						<tr>
							<td>������Ŀ����</td>
							<td><INPUT TYPE="text" NAME="FinancialProjectName" VALUE="" size="48"></td>
						</tr>
						<tr>
							<td width=25��><font color="#164DA8">�˲�����Ŀ��������</font></td>
							<td><SELECT NAME="SelectFinancialManager">
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
				</TR>
			</table>
			<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=1 align=center>
				<TR VALIGN="top" ALIGN="center">
					<TD WIDTH=100% align=center><INPUT TYPE="submit" NAME="AddProject"
						VALUE="��Ӵ˲�����Ŀ"
						style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
					<INPUT TYPE="submit" NAME="DeleteProject" VALUE="ɾ���˲�����Ŀ"
						style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
					</TD>
				</TR>
			</table>
		</table>
</table>
</FORM>
</BODY>
</HTML>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
