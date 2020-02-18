<%@ page contentType="text/html; charset=gb2312" language="java"  %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
String sql1 = "";
String sql2 = "";
String sql3 = "";
String sql4 = "";
String TheAddDate = "";
int QueryLabel = 0;
String TheName = "";
String TheDepartment = "";
String TheProjectName = "";
int TheFundTypeA = 0;
int TheFundTypeB = 0;
int TheFundTypeC = 0;
int TheFundTypeD = 0;
String TheSummary = "";
String TheRemark = "";
String TheModifyDate = "";
int TheSum = 0;
String temp = "";
String SqlString = "";
Calendar cal = Calendar.getInstance();
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
String Date = format.format(cal.getTime());
format = new SimpleDateFormat("yyyy");
String Year = format.format(cal.getTime());
format = new SimpleDateFormat("MM");
String Month = format.format(cal.getTime());
format = new SimpleDateFormat("dd");
String Day = format.format(cal.getTime());
ResultSet RSRecordResult = null;
ResultSet RSThisRecord = null;
Hashtable HTThisRecord = new Hashtable();
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
//查询某个财务记录
if (request.getParameter("Query") != null) {
	//获得用户的查询条件
	if (request.getParameter("QueryCheck1") != null
		&& (request.getParameter("FinancialRecordID") != null)) {
		sql1 = "and ID=" + request.getParameter("FinancialRecordID");
	}
	else {
		sql1 = " ";
	}
	if (request.getParameter("QueryCheck2") != null
		&& (request.getParameter("FinancialProjectName") != null)) {
		sql2 =
			" and ProjectName='"
				+ request.getParameter("FinancialProjectName")
				+ "'";
	}
	else {
		sql2 = " ";
	}
	if (request.getParameter("QueryCheck3") != null) {
		sql3 =
			" and Name='" + request.getParameter("SelectName") + "'";
	}
	else {
		sql3 = " ";
	}
	if (request.getParameter("QueryCheck4") != null) {
		TheAddDate =
			request.getParameter("AddYear")
				+ "-"
				+ request.getParameter("AddMonth")
				+ "-"
				+ request.getParameter("AddDay");
		sql4 = " and AddDate='" + TheAddDate + "' ";
	}
	else {
		sql4 = " ";
	}
	SqlString =
		"select * from FinancialRecord where AccountName='"
			+ session.getAttribute("Name")
			+ "' "
			+ sql1
			+ sql2
			+ sql3
			+ sql4
			+ " order by Name";
	System.out.println(SqlString);
	RSRecordResult = stmt.executeQuery(SqlString);
	TheMessage = "您查询的财务记录如下";
	QueryLabel = 2;
}
//用户选定了查询出来的某个财务记录
else if (request.getParameter("SelectRecord") != null) {
	TheMessage = "请在下面修改此条财务记录";
	RSThisRecord =
		stmt.executeQuery(
			"select * from FinancialRecord where ID="
				+ request.getParameter("RadioFinancialRecord"));
	QueryLabel = 3;
	while (RSThisRecord.next()) {
		HTThisRecord.put("ID", new Integer(RSThisRecord.getInt(1)));
		HTThisRecord.put("Name", RSThisRecord.getString(2));
		HTThisRecord.put("ProjectName", RSThisRecord.getString(4));
		HTThisRecord.put(
			"FundTypeA",
			new Integer(RSThisRecord.getInt(5)));
		HTThisRecord.put(
			"FundTypeB",
			new Integer(RSThisRecord.getInt(6)));
		HTThisRecord.put(
			"FundTypeC",
			new Integer(RSThisRecord.getInt(7)));
		HTThisRecord.put(
			"FundTypeD",
			new Integer(RSThisRecord.getInt(8)));
		HTThisRecord.put("Summary", RSThisRecord.getString(10));
		HTThisRecord.put("Remark", RSThisRecord.getString(11));
		HTThisRecord.put(
			"AddDate",
			RSThisRecord.getString(13).substring(0, 10));
	}
}
//用户对选定的财务记录进行了更新
else if (request.getParameter("UpdateRecord") != null) {
	//校验用户的输入
	try {
		NumberFormat numberformat = NumberFormat.getInstance();
		numberformat.parse(request.getParameter("UpdateFundTypeA"));
		numberformat.parse(request.getParameter("UpdateFundTypeB"));
		numberformat.parse(request.getParameter("UpdateFundTypeC"));
		numberformat.parse(request.getParameter("UpdateFundTypeD"));
		ResultSet RSLinkedDepartment =
			stmt.executeQuery(
				"select Department from PSLogins where Name='"
					+ request.getParameter("UpdateName")
					+ "'");
		TheName = request.getParameter("UpdateName");
		while (RSLinkedDepartment.next()) {
			TheDepartment =
				RSLinkedDepartment.getString("Department");
		}
		TheProjectName = request.getParameter("UpdateProjectName");
		TheFundTypeA =
			new Integer(request.getParameter("UpdateFundTypeA"))
				.intValue();
		TheFundTypeB =
			new Integer(request.getParameter("UpdateFundTypeB"))
				.intValue();
		TheFundTypeC =
			new Integer(request.getParameter("UpdateFundTypeC"))
				.intValue();
		TheFundTypeD =
			new Integer(request.getParameter("UpdateFundTypeD"))
				.intValue();
		TheSummary = request.getParameter("UpdateSummary");
		TheRemark = request.getParameter("UpdateRemark");
		TheModifyDate = Date;
		TheSum =
			TheFundTypeA + TheFundTypeB + TheFundTypeC + TheFundTypeD;
		//修改此条财务记录
		stmt.executeUpdate(
			"update FinancialRecord set Name='"
				+ TheName
				+ "',Department='"
				+ TheDepartment
				+ "',FundTypeA="
				+ TheFundTypeA
				+ ",FundTypeB="
				+ TheFundTypeB
				+ ",FundTypeC="
				+ TheFundTypeC
				+ ",FundTypeD="
				+ TheFundTypeD
				+ ",Sum="
				+ TheSum
				+ ",Summary='"
				+ TheSummary
				+ "',Remark='"
				+ TheRemark
				+ "',ModifyDate='"
				+ TheModifyDate
				+ "',ProjectName='"
				+ TheProjectName
				+ "' Where ID="
				+ request.getParameter("UpdateID"));
		QueryLabel = 3;
		TheMessage = "记录已经修改成功";
	}
	catch (Exception ex) {
		TheMessage = "记录中的款项字段中出现了非数字内容，无法修改此记录，请重填记录";
		Warning = true;
		QueryLabel = 3;
	}
	RSThisRecord =
		stmt.executeQuery(
			"select * from FinancialRecord where ID="
				+ request.getParameter("UpdateID"));
	while (RSThisRecord.next()) {
		HTThisRecord.put("ID", new Integer(RSThisRecord.getInt(1)));
		HTThisRecord.put("Name", RSThisRecord.getString(2));
		HTThisRecord.put("ProjectName", RSThisRecord.getString(4));
		HTThisRecord.put(
			"FundTypeA",
			new Integer(RSThisRecord.getInt(5)));
		HTThisRecord.put(
			"FundTypeB",
			new Integer(RSThisRecord.getInt(6)));
		HTThisRecord.put(
			"FundTypeC",
			new Integer(RSThisRecord.getInt(7)));
		HTThisRecord.put(
			"FundTypeD",
			new Integer(RSThisRecord.getInt(8)));
		HTThisRecord.put("Summary", RSThisRecord.getString(10));
		HTThisRecord.put("Remark", RSThisRecord.getString(11));
		HTThisRecord.put(
			"AddDate",
			RSThisRecord.getString(13).substring(0, 10));
	}
}
else {
	TheMessage = "请在下面填写您要修改的财务记录的查询条件";
	QueryLabel = 1;
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
		公司办公信息管理系统->公司财务信息管理系统->修改财务记录[当前用户- <%=session.getAttribute("Name")%>
		] </font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href=".././html/home.jsp"><font color="#104DAD">返回系统主页</font></a></td>
		<td align=center><%if (Warning == false) {%> <font color="#104DAD"><%=TheMessage%></FONT>
		<%}
else {%> <font color=Red><%=TheMessage%></font> <%}%></td>
		<td align=right><a href="finance.jsp"><font color="#104DAD">返回上一级网页</font></a></td>
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



<FORM ACTION="modifyfinancialrecord.jsp" METHOD=POST><%if (QueryLabel == 1) {%>
<TABLE CELLPADDING=1 CELLSPACING=2 BORDER=1 bordercolor="#164DA8"
	WIDTH=800 align=center>
	<TR VALIGN="middle" ALIGN="center">
		<TD WIDTH=20% bgcolor=#B5C7EF><img src="../image/finance1.jpg"></td>
		<td>

		<table CELLPADDING=1 CELLSPACING=1 BORDER=1 align=center width=100%
			bgcolor=White>
			<tr height=35>
				<td><input type=checkbox name=QueryCheck1 value="on"></td>
				<td>财务记录ID</td>
				<td><INPUT TYPE="text" NAME="FinancialRecordID" VALUE="" size=50></td>
			</tr>
			<tr height=35>
				<td><input type=checkbox name=QueryCheck2 value="on"></td>
				<td>财务项目名称</td>
				<td><INPUT TYPE="text" NAME="FinancialProjectName" VALUE="" size=50>
				</td>
			</tr>
			<tr height=35>
				<td><input type=checkbox name=QueryCheck3 value="on"></td>
				<td width=25％><font color="#164DA8">财务记录经手人</font></td>
				<td><SELECT NAME="SelectName">
					<%ResultSet RSPersons =
	stmt.executeQuery("select Name from PSLogins order by Name");
while (RSPersons.next()) {
	temp = RSPersons.getString("Name");%>
					<OPTION VALUE="<%=temp%>"><%=temp%></OPTION>
					<%}%>
				</SELECT></td>
			</tr>
			<tr height=35>
				<td><input type=checkbox name=QueryCheck4 value="on"></td>
				<td width=25％><font color="#164DA8">财务记录添加日期</font></td>
				<td><select name="AddYear" size=1>
					<OPTION VALUE="<%=Year%>"><%=Year%></OPTION>
					<%for (int YearCounter = 1990; YearCounter <= 2050; YearCounter++) {%>
					<OPTION VALUE="<%=YearCounter%>"><%=YearCounter%></OPTION>
					<%}%>
				</select>年 <select name="AddMonth" size=1>
					<OPTION VALUE="<%=Month%>"><%=Month%></OPTION>
					<%for (int MonthCounter = 1; MonthCounter <= 12; MonthCounter++) {%>
					<OPTION VALUE="<%=MonthCounter%>"><%=MonthCounter%></OPTION>
					<%}%>
				</select> 月 <select name="AddDay" size=1>
					<OPTION VALUE="<%=Day%>"><%=Day%></OPTION>
					<%for (int DayCounter = 1; DayCounter <= 31; DayCounter++) {%>
					<OPTION VALUE="<%=DayCounter%>"><%=DayCounter%></OPTION>
					<%}%>
				</select>日</td>
			</tr>
		</table>

		<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=1 WIDTH=100% align=center>
			<TR VALIGN="top" ALIGN="center">
				<TD WIDTH=100% align=center><INPUT TYPE="submit" NAME="Query"
					VALUE="查询符合条件的财务记录"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				</TD>
			</TR>
			<tr>
				<td><div align="center">注意:您只能修改您作为会计经手人的财务记录！</div></td>
			</tr>
		</table>

		</td>
	</TR>
</table>
<br>
<%}%> <%if (QueryLabel == 2) {%>

<table width=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>

	<tr>
		<td><font color=white>选中</font></td>
		<td><font color=white>记录ID</font></td>
		<td><font color=white>记录经手人</font></td>
		<td><font color=white>部门</font></td>
		<td><font color=white>所属财务项目</font></td>
		<td><font color=white>款项A</font></td>
		<td><font color=white>款项B</font></td>
		<td><font color=white>款项C</font></td>
		<td><font color=white>款项D</font></td>
		<td><font color=white>合计</font></td>
		<td><font color=white>添加日期</font></td>
		<td><font color=white>最新修改日期</font></td>
	</tr>
	<%int index = 0;
while (RSRecordResult.next()) {
	index = RSRecordResult.getInt("ID");
	out.println(
		"<tr bgcolor=white><td><input type=radio name=RadioFinancialRecord value="
			+ index
			+ "></td>");
	out.println("<td>" + index + "</td>");
	out.println("<td>" + RSRecordResult.getString("Name") + "</td>");
	out.println(
		"<td>" + RSRecordResult.getString("Department") + "</td>");
	out.println(
		"<td>" + RSRecordResult.getString("ProjectName") + "</td>");
	out.println(
		"<td>" + RSRecordResult.getInt("FundTypeA") + "</td>");
	out.println(
		"<td>" + RSRecordResult.getInt("FundTypeB") + "</td>");
	out.println(
		"<td>" + RSRecordResult.getInt("FundTypeC") + "</td>");
	out.println(
		"<td>" + RSRecordResult.getInt("FundTypeD") + "</td>");
	out.println("<td>" + RSRecordResult.getInt("Sum") + "</td>");
	out.println(
		"<td>"
			+ RSRecordResult.getString("AddDate").substring(0, 10)
			+ "</td>");
	temp = RSRecordResult.getString("ModifyDate");
	if (temp != null) {
		temp = temp.substring(0, 10);
	}
	out.println("<td>" + temp + "</td></tr>");
}
%>
</table>

<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="13"><img src=".././image/banner2.jpg" width="800"
			height="12"></td>
	</tr>
</table>
<p align=center><input type=submit name=SelectRecord value=选中某条财务记录
	style="border: 1px solid #3466BB; background-color: #FFFFFF; color: #3466BB">
<%}%> <%if (QueryLabel == 3) {%>
<TABLE CELLPADDING=1 CELLSPACING=2 BORDER=1 bordercolor="#164DA8"
	WIDTH=800 align=center>
	<TR VALIGN="middle" ALIGN="center">
		<TD WIDTH=20% bgcolor=#B5C7EF><img src="../image/finance1.jpg"></td>
		<td>

		<table CELLPADDING=1 CELLSPACING=1 BORDER=1 align=center width=100%>
			<tr>
				<td width=30%>财务记录号</td>
				<td><%=((Integer)HTThisRecord.get("ID")).intValue()%> <input
					name=UpdateID type=hidden
					value="<%=((Integer)HTThisRecord.get("ID")).intValue()%>"></td>
			</tr>
			<tr>
				<td width=30%>财务记录添加日期</td>
				<td><%=HTThisRecord.get("AddDate")%></td>
			</tr>
			<tr>
				<td width=30%>经手人</td>
				<td><Select name=UpdateName>
					<option value="<%=HTThisRecord.get("Name")%>"><%=HTThisRecord.get("Name")%></option>
					<%ResultSet RSPersons =
	stmt.executeQuery("select Name from PSLogins order by Name");
while (RSPersons.next()) {
	temp = RSPersons.getString("Name");
	out.println("<option value=" + temp + ">" + temp + "</option>");
}%>
				</select></td>
			</tr>
			<tr>
				<td width=30%>所属财务项目</td>
				<td><Select name=UpdateProjectName>
					<option value="<%=HTThisRecord.get("ProjectName")%>"><%=HTThisRecord.get("ProjectName")%></option>
					<%ResultSet RSFinancialProject =
	stmt.executeQuery(
		"select * from FinancialProject order by FinancialProjectName");
while (RSFinancialProject.next()) {
	temp = RSFinancialProject.getString("FinancialProjectName");
	out.println("<option value=" + temp + ">" + temp + "</option>");
}%>
				</select></td>
			</tr>
			<tr>
				<td width=30%>款项A</td>
				<td><input name=UpdateFundTypeA
					value="<%=((Integer)HTThisRecord.get("FundTypeA")).intValue()%>"></td>
			</tr>
			<tr>
				<td width=30%>款项B</td>
				<td><input name=UpdateFundTypeB
					value="<%=((Integer)HTThisRecord.get("FundTypeB")).intValue()%>"></td>
			</tr>
			<tr>
				<td width=30%>款项C</td>
				<td><input name=UpdateFundTypeC
					value="<%=((Integer)HTThisRecord.get("FundTypeC")).intValue()%>"></td>
			</tr>
			<tr>
				<td width=30%>款项D</td>
				<td><input name=UpdateFundTypeD
					value="<%=((Integer)HTThisRecord.get("FundTypeD")).intValue()%>"></td>
			</tr>
			<tr>
				<td width=30%>摘要</td>
				<td><input name=UpdateSummary
					value="<%=HTThisRecord.get("Summary")%>"></td>
			</tr>
			<tr>
				<td width=30%>备注</td>
				<td><input name=UpdateRemark value="<%=HTThisRecord.get("Remark")%>"></td>
			</tr>
		</table>
		<p align=center><input type=submit name=UpdateRecord value=修改此条财务记录
			style="border: 1px solid #3466BB; background-color: #FFFFFF; color: #3466BB">
		<%}%>
		</td>
	</tr>
</table>
</FORM>
</BODY>
</HTML>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
