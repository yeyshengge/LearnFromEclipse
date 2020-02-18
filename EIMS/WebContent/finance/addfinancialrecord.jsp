<%@ page contentType="text/html; charset=gb2312" language="java"  %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
String TheName = "";
String TheDepartment = "";
String TheProjectName = "";
int TheFundTypeA = 0;
int TheFundTypeB = 0;
int TheFundTypeC = 0;
int TheFundTypeD = 0;
String TheSummary = "";
String TheRemark = "";
String TheAccountName = "";
String TheDate = "";
int TheSum = 0;
boolean warning = false;
String temp = "";
NumberFormat numberformat = NumberFormat.getInstance();
//�ж��û��Ƿ��¼
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//�ж��û��Ƿ��ǲ������Ա
if (session.getAttribute("IsFinancialManager").equals("False")) {
	response.sendRedirect("finance.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
boolean Warning = false;
//��Ӳ�����Ŀ
if (request.getParameter("AddFinancialProject") != null) {
	response.sendRedirect("addfinancialproject.jsp");
}
//��Ӳ����¼��Ϣ
if (request.getParameter("AddRecord") != null) {
	//���б���ѡ������¼������
	TheName = request.getParameter("SelectFinancialRecordName");
	//���б���ѡ������¼������Ŀ
	TheProjectName = request.getParameter("SelectFinancialProject");
	//���û�����Ĳ����¼��Ϣ����У��
	try {
		numberformat.parse(request.getParameter("FundTypeA"));
		numberformat.parse(request.getParameter("FundTypeB"));
		numberformat.parse(request.getParameter("FundTypeC"));
		numberformat.parse(request.getParameter("FundTypeD"));
		TheFundTypeA =
			new Integer(request.getParameter("FundTypeA")).intValue();
		TheFundTypeB =
			new Integer(request.getParameter("FundTypeB")).intValue();
		TheFundTypeC =
			new Integer(request.getParameter("FundTypeC")).intValue();
		TheFundTypeD =
			new Integer(request.getParameter("FundTypeD")).intValue();
		TheSummary = request.getParameter("Summary");
		TheRemark = request.getParameter("Remark");
		TheAccountName = (String)session.getAttribute("Name");
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		TheDate = format.format(cal.getTime());
		TheSum =
			TheFundTypeA + TheFundTypeB + TheFundTypeC + TheFundTypeD;
		ResultSet RSDoExistName =
			stmt.executeQuery(
				"select * from PSLogins where Name='"
					+ TheName
					+ "'");
		while (RSDoExistName.next()) {
			TheDepartment = RSDoExistName.getString("Department");
		}
		//����²����¼�����ݿ�
		stmt.executeUpdate(
			" insert into FinancialRecord (Name, Department, "
				+ "ProjectName,FundTypeA, FundTypeB,FundTypeC, "
				+ "FundTypeD, Sum, Summary, Remark, AddDate, AccountName)"
				+ " values ('"
				+ TheName
				+ "','"
				+ TheDepartment
				+ "','"
				+ TheProjectName
				+ "','"
				+ TheFundTypeA
				+ "','"
				+ TheFundTypeB
				+ "','"
				+ TheFundTypeC
				+ "','"
				+ TheFundTypeD
				+ "','"
				+ TheSum
				+ "','"
				+ TheSummary
				+ "','"
				+ TheRemark
				+ "','"
				+ TheDate
				+ "','"
				+ TheAccountName
				+ "')");
		TheMessage = "��¼���ύ�ɹ�������д�¼�¼";
		Warning = false;
	}
	catch (ParseException ex) {
		TheMessage = "��¼�еĿ����ֶ��г����˷��������ݣ��޷���Ӵ˼�¼��������";
		Warning = true;
	}
}
else {
	TheMessage = "����������д�µĲ����¼";
	Warning = false;
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
		��˾�칫��Ϣ����ϵͳ->��˾������Ϣ����ϵͳ->��Ӳ����¼&nbsp[��ǰ�û�- <%=session.getAttribute("Name")%>
		] </font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="../html/home.jsp"><font color="#104DAD">����ϵͳ��ҳ</font></a></td>
		<td align=center><%if (Warning == false) {%> <font color="#104DAD"><%=TheMessage%></FONT>
		<%}
else {%> <font color=Red><%=TheMessage%></font> <%}%></td>
		<td align=right><a href="finance.jsp"><font color="#104DAD">������һ����ҳ</font></a></td>
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

<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="3" cellspacing="0">
	<tr>
		<td>

		<FORM ACTION="addfinancialrecord.jsp" METHOD=POST><br>

		<TABLE CELLPADDING=1 CELLSPACING=2 BORDER=1 bordercolor="#164DA8"
			WIDTH=800 align=center>
			<TR VALIGN="middle" ALIGN="center">
				
            <TD WIDTH=20% height="241" bgcolor=#B5C7EF><img src="../image/finance1.jpg"></td>
				<td>

				<table CELLPADDING=1 CELLSPACING=1 BORDER=1 align=center width=100%>
					<tr>
						<td width=25��><font color="#164DA8">�˲����¼����������</font></td>
						<td><SELECT NAME="SelectFinancialRecordName">
							<%ResultSet RSPersons =
	stmt.executeQuery("select Name from PSLogins order by Name");
while (RSPersons.next()) {
	temp = RSPersons.getString("Name");%>
							<OPTION VALUE="<%=temp%>"><%=temp%></OPTION>
							<%}%>
						</SELECT></td>
					</tr>

					<tr>
						
                  <td height="26"><font color="#164DA8">��Ŀ����</font></td>
						<td><SELECT NAME="SelectFinancialProject">
							<%ResultSet RSFinancialProject =
	stmt.executeQuery(
		"select FinancialProjectName from FinancialProject order by FinancialProjectName");
while (RSFinancialProject.next()) {
	temp = RSFinancialProject.getString("FinancialProjectName");%>
							<OPTION VALUE="<%=temp%>"><%=temp%></OPTION>
							<%}%>
						</SELECT></td>
					</tr>


					<tr>
						<td><font color="#164DA8">��������</font></td>
						<td>

						<table width=100% border=1>
							<tr>
								<td width=18%><font color="#164DA8">����A</font></td>
								<td width="82%"><INPUT TYPE="text" NAME="FundTypeA" VALUE="0"> Ԫ</td>
							</tr>
							<tr>
								<td><font color="#164DA8">����B</font></td>
								<td><INPUT TYPE="text" NAME="FundTypeB" VALUE="0"> Ԫ</td>
							</tr>
							<tr>
								<td><font color="#164DA8">����C</font></td>
								<td><INPUT TYPE="text" NAME="FundTypeC" VALUE="0"> Ԫ</td>
							</tr>
							<tr>
								<td><font color="#164DA8">����D</font></td>
								<td><INPUT TYPE="text" NAME="FundTypeD" VALUE="0"> Ԫ</td>
							</tr>
						</table>

						</td>
					</tr>
					<tr>
						<td><font color="#164DA8">ժҪ</font></td>
						<td><INPUT TYPE="text" NAME="Summary" VALUE="" size=50></td>
					</tr>
					<tr>
						<td><font color="#164DA8">��ע</font></td>
						<td><INPUT TYPE="text" NAME="Remark" VALUE="" size=50></td>
					</tr>


					<tr>
						<td><font color="#164DA8">��ƾ�����</font></td>
						<td><%=session.getAttribute("Name")%>&nbsp</td>
					</tr>
				</table>
				</td>
			</TR>
		</table>

		<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=1 WIDTH=800 align=center>
			<TR VALIGN="top" ALIGN="center">
				<TD WIDTH=100% align=center><INPUT TYPE="submit" NAME="AddRecord"
					VALUE="��Ӵ˼�¼"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				<INPUT TYPE="reset" NAME="Reset" VALUE="����˼�¼"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				<INPUT TYPE="submit" NAME="AddFinancialProject" VALUE="���ɾ��������Ŀ"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">

				</TD>
			</TR>
		</table>

		<br>
		</FORM>
		</td>
	</tr>
</table>


</BODY>
</HTML>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
