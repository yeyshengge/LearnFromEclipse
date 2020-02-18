<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
String temp = "";
String TheOrder = "";
String StartDate = "";
String EndDate = "";
String TheTimeLimit = "";
String SqlString = "";
ResultSet RSAllFinancialRecord = null;
//判断用户是否登录
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//连接系统数据库
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
boolean ReportLabel = false;
boolean Warning = false;
//判断当前页面状态是否是报表状态
if (request.getParameter("GoBack") != null) {
	ReportLabel = false;
}
//生成报表
if (request.getParameter("Send") != null) {
	//报表的排序方式
	if (request.getParameter("ReportOrder").equals("Name")) {
		TheOrder = "姓名";
	}
	else if (
		request.getParameter("ReportOrder").equals("ProjectName")) {
		TheOrder = "财务项目名称";
	}
	else if (
		request.getParameter("ReportOrder").equals("AccountName")) {
		TheOrder = "会计经手人";
	}
	else {
		TheOrder = "记录添加日期";
	}
	//报表是否有时间期限
	if (request.getParameter("DateLimit").equals("Yes")) {
		StartDate =
			request.getParameter("StartYear")
				+ "-"
				+ request.getParameter("StartMonth")
				+ "-"
				+ request.getParameter("StartDay");
		EndDate =
			request.getParameter("EndYear")
				+ "-"
				+ request.getParameter("EndMonth")
				+ "-"
				+ request.getParameter("EndDay");
		TheTimeLimit = "时间期限:从" + StartDate + "到" + EndDate;
	}
	else {
		StartDate = "1900-1-1";
		EndDate = "2100-1-1";
		TheTimeLimit = "时间期限:无";
	}
	//生成总流水帐报表
	if (request
		.getParameter("FinancialReportType")
		.equals("AllFinancialRecord")) {
		if (session.getAttribute("Position").equals("经理")
			|| (session.getAttribute("Department").equals("财务部")
				&& session.getAttribute("Position").equals("主管"))) {
			SqlString =
				"select * from FinancialRecord  where AddDate >='"
					+ StartDate
					+ "' and AddDate<='"
					+ EndDate
					+ "' order by "
					+ request.getParameter("ReportOrder");
			System.out.println(SqlString);
			RSAllFinancialRecord = stmt.executeQuery(SqlString);
			TheMessage =
				TheTimeLimit + "-总流水帐报表按-" + TheOrder + "-排序如下";
			ReportLabel = true;
		}
		else {
			TheMessage = "您不是[经理/财务部主管]，无权生成总流水帐报表";
			Warning = true;
		}
	}
	//生成部门财务报表
	else if (
		request.getParameter("FinancialReportType").equals(
			"DepartmentFinancialRecord")) {
		if (session.getAttribute("Position").equals("经理")
			|| (session
				.getAttribute("Department")
				.equals(request.getParameter("DepartmentName"))
				&& session.getAttribute("Position").equals("主管"))) {
			SqlString =
				"select * from FinancialRecord where Department = '"
					+ request.getParameter("DepartmentName")
					+ "' and AddDate >='"
					+ StartDate
					+ "' and AddDate<='"
					+ EndDate
					+ "' order by "
					+ request.getParameter("ReportOrder");
			System.out.println(SqlString);
			RSAllFinancialRecord = stmt.executeQuery(SqlString);
			ReportLabel = true;
			TheMessage =
				TheTimeLimit
					+ "-部门-"
					+ request.getParameter("DepartmentName")
					+ "-财务报表按-"
					+ TheOrder
					+ "-排序如下";
		}
		else {
			TheMessage = "您不是[经理/此部门主管]，无权生成部门财务报表";
			Warning = true;
		}
	}
	//生成项目财务报表
	else if (
		request.getParameter("FinancialReportType").equals(
			"FinancialProjectReport")) {
		ResultSet RSFinancailManager =
			stmt.executeQuery(
				"select FinancialManager from FinancialProject where FinancialProjectName='"
					+ request.getParameter("ProjectName")
					+ "'");
		while (RSFinancailManager.next()) {
			temp = RSFinancailManager.getString("FinancialManager");
		}
		if (session.getAttribute("Name").equals(temp)
			|| session.getAttribute("Position").equals("经理")) {
			SqlString =
				"select * from FinancialRecord where ProjectName = '"
					+ request.getParameter("ProjectName")
					+ "' and AddDate >='"
					+ StartDate
					+ "' and AddDate<='"
					+ EndDate
					+ "' order by "
					+ request.getParameter("ReportOrder");
			System.out.println(SqlString);
			RSAllFinancialRecord = stmt.executeQuery(SqlString);
			ReportLabel = true;
			TheMessage =
				TheTimeLimit
					+ "-项目-"
					+ request.getParameter("ProjectName")
					+ "-财务报表按-"
					+ TheOrder
					+ "-排序如下";
		}
		else {
			TheMessage = "您不是[经理 /此财务项目主管]，无权生成总流水帐报表";
			Warning = true;
		}
	}
	//生成个人财务报表
	else {
		if (session.getAttribute("Position").equals("经理")
			|| session.getAttribute("Name").equals(
				request.getParameter("Person"))) {
			SqlString =
				"select * from FinancialRecord where Name = '"
					+ request.getParameter("Person")
					+ "' and AddDate >='"
					+ StartDate
					+ "' and AddDate<='"
					+ EndDate
					+ "' order by "
					+ request.getParameter("ReportOrder");
			System.out.println(SqlString);
			RSAllFinancialRecord = stmt.executeQuery(SqlString);
			ReportLabel = true;
			TheMessage =
				TheTimeLimit
					+ "-用户-"
					+ request.getParameter("Person")
					+ "-个人财务报表按-"
					+ TheOrder
					+ "-排序如下";
		}
		else {
			TheMessage = "您不是[经理/此个用户]，无权生成此用户个人财务报表";
			Warning = true;
		}
	}
}
else {
	TheMessage = "请选择您要生成的报表类型";
}
%>



<HTML>
<HEAD>
<TITLE>公司财务信息管理系统</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</HEAD>

<BODY BGCOLOR="">

<FORM ACTION="financialreport.jsp" METHOD=POST><%if (ReportLabel == false) {%>
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
		公司办公信息管理系统->财务信息管理子系统->生成财务报表[当前用户- <%=session.getAttribute("Name")%>
		] </font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href=../html/home.jsp><font color=#104DAD>返回系统主页</font></a></td>
		<td align=center><%if (Warning == false) {%> <font color="#104DAD"><%=TheMessage%></FONT>
		<%}
else {%> <font color=Red><%=TheMessage%></font> <%}%></td>
		<td align=right><a href=finance.jsp><font color=#104DAD>返回上一级网页</font></a></td>
	</tr>
</table>
<table width=800 border=0 bordercolor=#164DA8 align=center cellpadding=0
	cellspacing=0>
	<tr>
		<td height=10 colspan=4 valign=top bgcolor=#FFFFFF><img
			src=../image/banner2.jpg width=800 height=12></td>
	</tr>
</table>

<TABLE CELLPADDING=1 CELLSPACING=2 BORDER=1 bordercolor=#164DA8
	WIDTH=800 align=center>
	<TR VALIGN=middle ALIGN=center>
		<TD WIDTH=35% bgcolor=#B5C7EF><img src=../image/finance1.jpg></td>
		<td>

		<table cellpadding=1 cellspacing=1 border=1 bordercolor=#164DA8
			align=center width=100%>
			<tr>
				<td colspan=4 align=center bgcolor=#B5C7EF><font color=#164DA8>报表类型</font></td>
			</tr>
			<tr>
				<td><INPUT TYPE=radio CHECKED NAME=FinancialReportType
					VALUE=AllFinancialRecord>总流水帐报表</td>
				<td><INPUT TYPE=radio NAME=FinancialReportType
					VALUE=DepartmentFinancialRecord>部门财务报表</td>
				<td><INPUT TYPE=radio NAME=FinancialReportType
					VALUE=FinancialProjectReport>项目财务报表</td>
				<td><INPUT TYPE=radio NAME=FinancialReportType
					VALUE=PersonalFinancialReport>个人财务报表</td>
			</tr>
			<tr>
				<td>;</td>
				<td><SELECT NAME=DepartmentName>
					<%ResultSet RSDepartments =
	stmt.executeQuery(
		"select  DepartmentName from Departments order by DepartmentName");
while (RSDepartments.next()) {
	temp = RSDepartments.getString("DepartmentName");
	out.println("<OPTION VALUE=" + temp + ">" + temp + "</OPTION>");
}
out.println("</SELECT></td>");
out.println("<td><SELECT NAME=ProjectName >");
ResultSet RSProjectName =
	stmt.executeQuery(
		"select * from FinancialProject order by FinancialProjectName");
while (RSProjectName.next()) {
	temp = RSProjectName.getString("FinancialProjectName");
	out.println("<OPTION VALUE=" + temp + ">" + temp + "</OPTION>");
}
%>
				</SELECT></td>
				<td><SELECT NAME=Person>
					<%ResultSet RSPerson =
	stmt.executeQuery("select Name from PSLogins order by Name");
while (RSPerson.next()) {
	temp = RSPerson.getString("Name");
	out.println("<OPTION VALUE=" + temp + ">" + temp + "</OPTION>");
}
%>
				</SELECT></td>
			<tr>
		</table>
		<br>

		<table cellpadding=1 cellspacing=1 border=1 bordercolor=#164DA8
			align=center width=100%>
			<tr>
				<td colspan=4 align=center bgcolor=#B5C7EF><font color=#164DA8>排序方式</font></td>
			</tr>
			<tr>
				<td><INPUT TYPE=radio CHECKED NAME=ReportOrder VALUE=Name>按经手人姓名排序</td>
				<td><INPUT TYPE=radio NAME=ReportOrder VALUE=ProjectName>按项目排序</td>
				<td><INPUT TYPE=radio NAME=ReportOrder VALUE=AccountName>按会计经手人排序</td>
				<td><INPUT TYPE=radio NAME=ReportOrder VALUE=AddDate>按日期排序</td>
			</tr>
		</table>
		<br>

		<table cellpadding=1 cellspacing=1 border=1 bordercolor=#164DA8
			align=center width=100%>
			<tr>
				<td colspan=2 align=center bgcolor=#B5C7EF><font color=#164DA8>时间期限</font></td>
			</tr>
			<tr>
				<td><INPUT TYPE=radio CHECKED NAME=DateLimit VALUE=No>无时间限制</td>
				<td>;</td>
			</tr>
			<tr>
				<td><INPUT TYPE=radio NAME=DateLimit VALUE=Yes>有时间期限</td>
				<%Calendar cal = Calendar.getInstance();
SimpleDateFormat format = new SimpleDateFormat("yyyy");
String Year = format.format(cal.getTime());
format = new SimpleDateFormat("MM");
String Month = format.format(cal.getTime());
format = new SimpleDateFormat("dd");
String Day = format.format(cal.getTime());
%>
				<td>
				<table border=1 width=100%>
					<tr>
						<td>开始时间</td>
						<td><select name="StartYear" size=1>
							<OPTION VALUE="<%=Year%>"><%=Year%></OPTION>
							<%for (int YearCounter = 1990; YearCounter <= 2050; YearCounter++) {%>
							<OPTION VALUE="<%=YearCounter%>"><%=YearCounter%></OPTION>
							<%}%>
						</select>年</td>
						<td><select name="StartMonth" size=1>
							<OPTION VALUE="<%=Month%>"><%=Month%></OPTION>
							<%for (int MonthCounter = 1; MonthCounter <= 12; MonthCounter++) {%>
							<OPTION VALUE="<%=MonthCounter%>"><%=MonthCounter%></OPTION>
							<%}%>
						</select> 月</td>
						<td><select name="StartDay" size=1>
							<OPTION VALUE="<%=Day%>"><%=Day%></OPTION>
							<%for (int DayCounter = 1; DayCounter <= 31; DayCounter++) {%>
							<OPTION VALUE="<%=DayCounter%>"><%=DayCounter%></OPTION>
							<%}%>
						</select>日</td>
					</tr>
					<tr>
						<td>截至时间</td>
						<td><select name="EndYear" size=1>
							<OPTION VALUE="<%=Year%>"><%=Year%></OPTION>
							<%for (int YearCounter = 2050; YearCounter >= 1990; YearCounter--) {%>
							<OPTION VALUE="<%=YearCounter%>"><%=YearCounter%></OPTION>
							<%}%>
						</select>年</td>
						<td><select name="EndMonth" size=1>
							<OPTION VALUE="<%=Month%>"><%=Month%></OPTION>
							<%for (int MonthCounter = 1; MonthCounter <= 12; MonthCounter++) {%>
							<OPTION VALUE="<%=MonthCounter%>"><%=MonthCounter%></OPTION>
							<%}%>
						</select>月</td>
						<td><select name="EndDay" size=1>
							<OPTION VALUE="<%=Day%>"><%=Day%></OPTION>
							<%for (int DayCounter = 1; DayCounter <= 31; DayCounter++) {%>
							<OPTION VALUE="<%=DayCounter%>"><%=DayCounter%></OPTION>
							<%}%>
						</select>日</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=1 WIDTH=800 align=center>
	<TR VALIGN=top ALIGN=center>
		<TD align=center><INPUT TYPE=submit NAME=Send VALUE=生成财务报表
			style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
		</td>
	</tr>
</table>

<%}
%> <br>

<%if (ReportLabel == true) {%>
<table width=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>
	<tr>
		<td><div align="center"><font color=white><%=TheMessage%> </font></div></td>
	</tr>
	<tr bgcolor=white>
		<td align=center>
		<table width=800 bgcolor=#164DA8 border=0 cellspacing=1 cellpadding=2
			align=center>
			<tr>
				<td><font color=white>记录ID</font></td>
				<td><font color=white>经手人姓名</font></td>
				<td><font color=white>部门</font></td>
				<td><font color=white>财务项目名称</font></td>
				<td align=right><font color=white>款项A(元)</font></td>
				<td align=right><font color=white>款项B(元)</font></td>
				<td align=right><font color=white>款项C(元)</font></td>
				<td align=right><font color=white>款项D(元)</font></td>
				<td align=right><font color=white>合计(元)</font></td>
				<td><font color=white>会计经手人</font></td>
				<td><font color=white>添加日期</font></td>
			</tr>

			<%int SumFundTypeA = 0;
int SumFundTypeB = 0;
int SumFundTypeC = 0;
int SumFundTypeD = 0;
int SumSum = 0;
int fta = 0;
int ftb = 0;
int ftc = 0;
int ftd = 0;
int ftsum = 0;
try {
	while (RSAllFinancialRecord.next()) {
		out.println(
			"<tr bgcolor=white><td>"
				+ RSAllFinancialRecord.getInt(1)
				+ "</td><td>"
				+ RSAllFinancialRecord.getString(2)
				+ "</td><td>"
				+ RSAllFinancialRecord.getString(3)
				+ "</td><td>"
				+ RSAllFinancialRecord.getString(4)
				+ "</td>");
		fta = RSAllFinancialRecord.getInt("FundTypeA");
		ftb = RSAllFinancialRecord.getInt("FundTypeB");
		ftc = RSAllFinancialRecord.getInt("FundTypeC");
		ftd = RSAllFinancialRecord.getInt("FundTypeD");
		ftsum = RSAllFinancialRecord.getInt("Sum");
		out.println(
			"<td align=right>"
				+ fta
				+ "</td><td align=right>"
				+ ftb
				+ "</td><td align=right>"
				+ ftc
				+ "</td><td align=right>"
				+ ftd
				+ "</td><td align=right>"
				+ ftsum
				+ "</td><td>"
				+ RSAllFinancialRecord.getString(12)
				+ "</td><td>"
				+ RSAllFinancialRecord.getString(13).substring(0, 10)
				+ "</td></tr>");
		SumFundTypeA += fta;
		SumFundTypeB += ftb;
		SumFundTypeC += ftc;
		SumFundTypeD += ftd;
		SumSum += ftsum;
	}
}
catch (Exception ex) {
	System.err.println(ex);
	SumFundTypeA = 0;
	SumFundTypeB = 0;
	SumFundTypeC = 0;
	SumFundTypeD = 0;
	SumSum = 0;
}
%>
			<tr bgcolor=white>
				<td>合计</td>
				<td>;</td>
				<td>;</td>
				<td>;</td>
				<td align=right><%=SumFundTypeA%></td>
				<td align=right><%=SumFundTypeB%></td>
				<td align=right><%=SumFundTypeC%></td>
				<td align=right><%=SumFundTypeD%></td>
				<td align=right><%=SumSum%></td>
				<td>;</td>
				<td>;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<p align=center><input type=submit name=GoBack value=生成新报表
	style="border: 1px solid #3466BB; background-color: #FFFFFF; color: #3466BB">
</p>
<%}
%></FORM>

</BODY>
</HTML>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
