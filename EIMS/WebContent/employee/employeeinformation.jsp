<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
Vector VTDepartments = new Vector();
Vector VTRoles = new Vector();
if (session.getAttribute("VTDepartments") != null) {
	VTDepartments = (Vector)session.getAttribute("VTDepartments");
}
if (session.getAttribute("VTRoles") != null) {
	VTRoles = (Vector)session.getAttribute("VTRoles");
}
String temp = "";
boolean label = false;
//判断用户是否登录
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//连接系统数据库
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
ResultSet RSEnquiryResult = null;
//判断用户是否提交了表单
if (request.getParameter("Send") != null) {
	//如果用户希望查询全部员工信息
	if (request
		.getParameter("SendTo")
		.equals("AllEmployeeInformation")) {
		RSEnquiryResult =
			stmt.executeQuery(
				"select * from PSLogins order by "
					+ request.getParameter("AllOrder"));
		TheMessage =
			"全体员工信息按" + request.getParameter("AllOrder") + "排序如下";
		label = true;
	}
	//如果用户希望查询某个部门员工信息
	else if (
		request.getParameter("SendTo").equals(
			"DepartmentEmployeeInformation")) {
		RSEnquiryResult =
			stmt.executeQuery(
				"select * from PSLogins where Department = '"
					+ request.getParameter("DepartmentName")
					+ "' order by Position");
		TheMessage =
			request.getParameter("DepartmentName") + "全部员工信息如下";
		label = true;
	}
	//如果用户希望进入修改个人信息页面
	else if (
		request.getParameter("SendTo").equals(
			"ModifyPersonalInformation")) {
		response.sendRedirect("modifypersonalinformation.jsp");
	}
	//如果用户希望进入系统管理员页面
	else if (
		request.getParameter("SendTo").equals("SystemManager")) {
		if (session.getAttribute("IsSystemManager").equals("True")) {
			session.setAttribute(
				"SystemOrder",
				request.getParameter("SystemOrder"));
			response.sendRedirect("systemmanager.jsp");
		}
		else {
			TheMessage = " 对不起，您不是系统管理员，没有此项权限";
			label = false;
		}
	}
	//如果用户希望查询某个员工信息
	else if (
		request.getParameter("SendTo").equals(
			"OneEmployeeInformation")) {
		label = true;
		if (request.getParameter("CheckName").equals("FromList")) {
			RSEnquiryResult =
				stmt.executeQuery(
					"select * from PSLogins where Name = '"
						+ request.getParameter("RoleName")
						+ "'");
			TheMessage =
				"查询员工" + request.getParameter("RoleName") + "信息结果如下";
		}
		else {
			RSEnquiryResult =
				stmt.executeQuery(
					"select * from PSLogins where Name = '"
						+ request.getParameter("TypeName")
						+ "'");
			TheMessage =
				"查询员工" + request.getParameter("TypeName") + "信息结果如下";
		}
	}
	//如果用户希望查询部门主管信息
	else {
		RSEnquiryResult =
			stmt.executeQuery(
				"select * from PSLogins where Position='主管'");
		TheMessage = "各部门主管信息如下";
		label = true;
	}
}
//如果用户是第一次进入页面
else {
	TheMessage = "请在下面选择员工信息管理选项";
	if (session.getAttribute("VTDepartments") != null) {
		VTDepartments = (Vector)session.getAttribute("VTDepartments");
	}
	else {
		ResultSet RSDepartments =
			stmt.executeQuery(
				"select DepartmentName from Departments");
		while (RSDepartments.next()) {
			VTDepartments.add(
				RSDepartments.getString("DepartmentName"));
		}
		session.setAttribute("VTDepartments", VTDepartments);
	}

	if (session.getAttribute("VTRoles") != null) {
		VTRoles = (Vector)session.getAttribute("VTRoles");
	}
	else {
		ResultSet RSRoles =
			stmt.executeQuery("select Name from PSLogins");
		while (RSRoles.next()) {
			VTRoles.add(RSRoles.getString("Name"));
		}
		session.setAttribute("VTRoles", VTRoles);
	}
}
%>

<html>
<head>
<title>员工信息管理子系统</title>
</head>
<body>

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
		公司办公信息管理系统->员工信息管理子系统&nbsp[当前用户-<%=session.getAttribute("Name")%>] </font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="../html/home.jsp"><font color="#104DAD">返回系统主页</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href="../html/home.jsp"><font color="#104DAD">返回上一级网页</font></a></td>
	</tr>
</table>

<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="13"><img src=".././image/banner2.jpg" width="800"
			height="12"></td>
	</tr>
</table>
<form action="employeeinformation.jsp#List" method=post>
<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="3" cellspacing="0">
	<tr>
		<td><br>



		<table cellpadding=1 cellspacing=2 border=1 bordercolor="#164DA8"
			width=800 align=center>
			<tr valign="middle" align="center">
				<td width=35% bgcolor=#B5C7EF><img src="../image/employee1.jpg"></td>
				<td>

				<table cellpadding=1 cellspacing=1 border=1 align=center width=100%>
					<tr>
						<td width=35％><input type="radio" checked name="SendTo"
							value="AllEmployeeInformation"> <font color="#164DA8">查询所有员工信息</font></td>
						<td><input type="radio" checked name="AllOrder" value="Name">按姓名排序
						<input type="radio" name="AllOrder" value="Department">按部门排序 <input
							type="radio" name="AllOrder" value="Birthday">按生日排序</td>
					</tr>
					<tr>
						<td width=30％><input type="radio" name="SendTo"
							value="DepartmentEmployeeInformation"> <font color="#164DA8">查询某个部门员工信息</font></td>
						<td><select name="DepartmentName">
							<%for (int i = 0; i < VTDepartments.size(); i++) {
	temp = (String)VTDepartments.get(i);%>
							<option value="<%=temp%>"><%=temp%></option>
							<%}%>
						</select></td>
					</tr>

					<tr>
						<td><input type="radio" name="SendTo"
							value="OneEmployeeInformation"><font color="#164DA8">查询某个员工信息</font>
						</td>
						<td>

						<table width=100% border=1>
							<tr>
								<td><input type="radio" Checked name="CheckName"
									value="FromList"><font color="#164DA8">从列表中选择</font></td>
								<td><select name="RoleName">
									<%for (int i = 0; i < VTRoles.size(); i++) {
	temp = (String)VTRoles.get(i);%>
									<option value="<%=temp%>"><%=temp%></option>
									<%}%>
								</select></td>
							</tr>
							<tr>
								<td><input type="radio" name="CheckName" value="Type"><font
									color="#164DA8">从输入的名字查询</font></td>
								<td><input type="text" Checked name="TypeName" value=""></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width=30%><input type="radio" name="SendTo"
							value="DepartmentManager"> <font color="#164DA8">查询部门主管信息</font></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td width=30%><input type="radio" name="SendTo"
							value="ModifyPersonalInformation"> <font color="#164DA8">修改关于我的信息</font></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td width=30%><input type="radio" name="SendTo"
							value="SystemManager"> <font color="#164DA8">系统管理员选项</font></td>
						<td><input type="radio" name=SystemOrder value="Name" checked>以姓名排序进入
						<input type="radio" name=SystemOrder value="Department">以部门排序进入<br>
						<input type="radio" name=SystemOrder value="Birthday">以生日排序进入 <input
							type="radio" name=SystemOrder value="Position">以职位排序进入</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>

		<table cellpadding=0 cellspacing=0 BORDER=1 width=800 align=center>
			<tr VALIGN="top" ALIGN="center">
				<td width=100% align=center><input type="submit" name="Send"
					value="进入选项"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				</td>
			</tr>
		</table>

		<br>
		<A name=List></A> <%if (request.getParameter("Send") != null) {
	out.println(
		"<table width=100% border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2 align=center>");
	out.println(
		"<tr><td><font color=white><P ALIGN=CENTER>" + TheMessage);
	out.println("</font></td></tr>");
	//如果不输出查询结果
	if (label == false) {
		out.println("</table>");
	}
	//如果要输出查询结果
	else {
		out.println("<tr bgcolor=white ><td  align=center>");
		out.println(
			"<table width=100% bgcolor=#164DA8 border=0  cellspacing=1 cellpadding=2 align=center>");
		out.println("<tr><td><font color=white>登录名</font></td>");
		out.println("<td><font color=white>姓名</font></td>");
		out.println("<td><font color=white>电子邮件地址</font></td>");
		out.println("<td><font color=white>部门</font></td>");
		out.println("<td><font color=white>内部分机</font></td>");
		out.println("<td><font color=white>家庭电话</font></td>");
		out.println("<td><font color=white>移动电话</font></td>");
		out.println("<td><font color=white>MSN</font></td>");
		out.println("<td><font color=white>生日</font></td></tr>");
		while (RSEnquiryResult.next()) {
			out.println("<tr bgcolor=white>");
			out.println(
				"<td>" + RSEnquiryResult.getString(2) + "</td>");
			out.println(
				"<td>" + RSEnquiryResult.getString(3) + "</td>");
			temp = RSEnquiryResult.getString(5);
			out.println("<td><a href=mailto:" + temp + ">");
			out.println(
				"<font face=arial>" + temp + "</font></a></td>");
			out.println(
				"<td>" + RSEnquiryResult.getString(6) + "</td>");
			out.println(
				"<td>" + RSEnquiryResult.getString(8) + "</td>");
			out.println(
				"<td>" + RSEnquiryResult.getString(9) + "</td>");
			out.println(
				"<td>" + RSEnquiryResult.getString(10) + "</td>");
			out.println(
				"<td>" + RSEnquiryResult.getString(11) + "</td>");
			out.println(
				"<td>"
					+ RSEnquiryResult.getString(14).substring(0, 10)
					+ "</td></tr>");
		}
		out.println("</table></td></tr></table>");
	}
}%></td>
	</tr>
</table>
</form>
</body>
</html>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
