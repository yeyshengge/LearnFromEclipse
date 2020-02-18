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
//判断用户是否登录
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//判断用户是否具有财务管理员身份
if (session.getAttribute("IsFinancialManager").equals("False")) {
	response.sendRedirect("finance.jsp");
}
//连接系统数据库
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
boolean Warning = false;
//添加新财务项目
if (request.getParameter("AddProject") != null) {
	TheFinancialProjectName =
		request.getParameter("FinancialProjectName");
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	TheAddDate = format.format(cal.getTime());
	//校验用户是否是财务部门的主管
	if (session.getAttribute("Department").equals("财务部")
		&& session.getAttribute("Position").equals("主管")) {
		//从列表中选择新财务项目的负责人
		TheFinancialManager =
			request.getParameter("SelectFinancialManager");
		//校验用户的输入是否合乎要求
		if (TheFinancialProjectName.trim().equals("")) {
			TheMessage = "财务项目名称不能为空，请重填新财务项目名称";
			Warning = true;
		}
		else {
			//向数据库添加新财务项目
			stmt.executeUpdate(
				"insert into FinancialProject (FinancialProjectName, AddDate, FinancialManager) values ('"
					+ TheFinancialProjectName
					+ "','"
					+ TheAddDate
					+ "','"
					+ TheFinancialManager
					+ "')");
			TheMessage = "财务项目已提交成功，请填写新财务项目";
			Warning = false;
		}
	}
	else {
		TheMessage = "您不是财务部主管，无权添加财务项目";
		Warning = true;
	}
}
//删除某个财务项目
else if (request.getParameter("DeleteProject") != null) {
	//判断用户是否是财务部门主管
	if (session.getAttribute("Department").equals("财务部")
		&& session.getAttribute("Position").equals("主管")) {
		stmt.executeUpdate(
			"delete from FinancialProject where FinancialProjectID="
				+ request.getParameter("RadioFinancialProject"));
		TheMessage = "您已经删除了此财务项目";
	}
	else {
		TheMessage = "您不是财务部主管，无权删除此财务项目";
		Warning = true;
	}
}
else {
	TheMessage = "请在下面填写新的财务项目";
}
%>



<HTML>
<HEAD>
<TITLE>公司财务信息管理系统</TITLE>
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
		公司办公信息管理系统->公司财务信息管理系统->添加财务记录&nbsp->添加财务项目[当前用户-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="../html/home.jsp"><font color="#104DAD">返回系统主页</font></a></td>
		<td align=center><%if (Warning == false) {%> <font color="#104DAD"><%=TheMessage%></FONT>
		<%}
else {%> <font color=Red><%=TheMessage%></font> <%}%></td>
		<td align=right><a href="addfinancialrecord.jsp"><font color="#104DAD">返回上一级网页</font></a></td>
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
				<td>选中</td>
				<td>财务项目ID</td>
				<td>财务项目名称</td>
				<td>添加日期</td>
				<td>项目主管</td>
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
							<td>财务项目名称</td>
							<td><INPUT TYPE="text" NAME="FinancialProjectName" VALUE="" size="48"></td>
						</tr>
						<tr>
							<td width=25％><font color="#164DA8">此财务项目主管姓名</font></td>
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
						VALUE="添加此财务项目"
						style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
					<INPUT TYPE="submit" NAME="DeleteProject" VALUE="删除此财务项目"
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
