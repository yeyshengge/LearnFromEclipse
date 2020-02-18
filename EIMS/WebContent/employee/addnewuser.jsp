<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>
<%@ page import="cn.edu.buaa.nlsde.md5.MD5"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
String temp = "";
//判断用户是否登录以及具有系统管理员身份
if (session.getAttribute("ID") == null
	|| session.getAttribute("IsSystemManager").equals("false")) {
	response.sendRedirect("../login.jsp");
}
//连接系统数据库
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
ResultSet RSDepartments =
	stmt.executeQuery(
		"select DepartmentName from Departments order by DepartmentName");
//添加新用户
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
	//对用户输入进行校验，合格则添加新用户信息
	if (ThePassword.trim().equals("")
		|| TheName.trim().equals("")
		|| TheLoginID.trim().equals("")) {
		TheMessage = "登录名，姓名，密码不能为空，无法添加新用户";
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
		TheMessage = "新用户添加成功,请继续添加";
	}
}
else {
	TheMessage = "请在下面添加新用户";
}
%>



<HEAD>
<TITLE>添加新用户</TITLE>
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
		公司办公信息管理系统->员工信息查询->系统管理员选项->增加新用户[当前用户- <%=session.getAttribute("Name")%>
		] </FONT></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="../html/home.jsp"><font color="#164DA8">返回系统主页</font></a></td>
		<td align=center><font color="#164DA8"><%=TheMessage%></FONT></td>
		<td align=right><a href="systemmanager.jsp"><font color="#164DA8">返回上一级网页</font></a></td>
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
				<td width=25%><font color="#164DA8">登录名</font></td>
				<td><INPUT TYPE="text" NAME="LoginID" VALUE="" SIZE=50 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">姓名</font></td>
				<td><INPUT TYPE="text" NAME="Name" VALUE="" SIZE=50 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">输入新密码</font></td>
				<td><INPUT TYPE="text" NAME="Password" VALUE="" SIZE=50 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">部门</font></td>
				<td><SELECT NAME="Department" size=1 width=10>
					<%while (RSDepartments.next()) {
	temp = RSDepartments.getString("DepartmentName");%>
					<OPTION VALUE="<%=temp%>"><%=temp%></OPTION>
					<%}%>
				</SELECT></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">职位</font></td>
				<td><select name="Position" size=1>
					<option value="普通">普通</option>
					<option value="主管">主管</option>
					<option value="经理">经理</option>
				</select></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">电子邮件地址</font></td>
				<td><INPUT TYPE="text" NAME="EmailAddress" VALUE="" SIZE=50
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">内部分机电话</font></td>
				<td><INPUT TYPE="text" NAME="InternalPhone" VALUE="" SIZE=50
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">移动电话</font></td>
				<td><INPUT TYPE="text" NAME="MobilePhone" VALUE="" SIZE=50
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">家庭电话</font></td>
				<td><INPUT TYPE="text" NAME="HomePhone" VALUE="" SIZE=50
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">MSN</font></td>
				<td><INPUT TYPE="text" NAME="MSN" VALUE="" SIZE=50 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">家庭住址</font></td>
				<td><INPUT TYPE="text" NAME="HomeAddress" VALUE="" SIZE=50
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">是否系统管理员</font></td>
				<td><select name="IsSystemManager" size=1>
					<option value="False">否</option>
					<option value="True">是</option>
				</select></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">生日</font></td>
				<td><select name="BirthdayYear" size=1>
					<%for (int YearCounter = 2000; YearCounter >= 1900; YearCounter--) {%>
					<OPTION VALUE="<%=YearCounter%>"><%=YearCounter%></OPTION>
					<%}%>
				</select> 年 <select name="BirthdayMonth" size=1>
					<%for (int MonthCounter = 1; MonthCounter <= 12; MonthCounter++) {%>
					<OPTION VALUE="<%=MonthCounter%>"><%=MonthCounter%></OPTION>
					<%}%>
				</select> 月 <select name="BirthdayDay" size=1>
					<%for (int DayCounter = 1; DayCounter <= 31; DayCounter++) {%>
					<OPTION VALUE="<%=DayCounter%>"><%=DayCounter%></OPTION>
					<%}%>
				</select> 日</td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">是否财务管理员</font></td>
				<td><select name="IsFinancialManager" size=1>
					<option value="False">否</option>
					<option value="True">是</option>
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
			VALUE="添加新用户信息"
			style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB"></TD>
	</TR>
</table>

</form>
</body>
</html>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
