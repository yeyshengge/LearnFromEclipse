<%@ page contentType="text/html; charset=gb2312" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>
<%@ page import="cn.edu.buaa.nlsde.md5.MD5"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
//判断用户是否登录
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//连接系统数据库
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//如果用户提交了表单
if (request.getParameter("Send") != null) {
	//进行用户身份校验
	if (new MD5()
		.getMD5ofStr(request.getParameter("Password"))
		.equals(session.getAttribute("Password"))) {
		if (request.getParameter("NewPassword").trim().equals("")) {
			session.setAttribute(
				"EmailAddress",
				request.getParameter("EmailAddress"));
			session.setAttribute(
				"InternalPhone",
				request.getParameter("InternalPhone"));
			session.setAttribute(
				"HomePhone",
				request.getParameter("HomePhone"));
			session.setAttribute(
				"MobilePhone",
				request.getParameter("MobilePhone"));
			session.setAttribute("MSN", request.getParameter("MSN"));
			session.setAttribute(
				"HomeAddress",
				request.getParameter("HomeAddress"));
			if (new Integer(request.getParameter("BirthdayDay"))
				.intValue()
				< 10) {
				session.setAttribute(
					"Birthday",
					request.getParameter("BirthdayYear")
						+ "-"
						+ request.getParameter("BirthdayMonth")
						+ "-0"
						+ request.getParameter("BirthdayDay"));
			}
			else {
				session.setAttribute(
					"Birthday",
					request.getParameter("BirthdayYear")
						+ "-"
						+ request.getParameter("BirthdayMonth")
						+ "-"
						+ request.getParameter("BirthdayDay"));
			}
			//更新用户个人信息
			stmt.executeUpdate(
				"update PSLogins set EmailAddress='"
					+ request.getParameter("EmailAddress")
					+ "',  InternalPhone='"
					+ request.getParameter("InternalPhone")
					+ "',HomePhone='"
					+ request.getParameter("HomePhone")
					+ "', MobilePhone='"
					+ request.getParameter("MobilePhone")
					+ "', MSN='"
					+ request.getParameter("MSN")
					+ "',HomeAddress='"
					+ request.getParameter("HomeAddress")
					+ "',Birthday='"
					+ request.getParameter("BirthdayYear")
					+ "-"
					+ request.getParameter("BirthdayMonth")
					+ "-"
					+ request.getParameter("BirthdayDay")
					+ "' Where Name='"
					+ request.getParameter("Name")
					+ "'");
			TheMessage = "您的个人信息已经修改成功";
		}
		else {
			//如果用户输入了新密码
			if (request
				.getParameter("NewPassword")
				.equals(request.getParameter("ConfirmNewPassword"))) {
				//session.setAttribute("Name", request.getParameter("Name"));
				session.setAttribute(
					"Password",
					new MD5().getMD5ofStr(
						request.getParameter("NewPassword")));
				session.setAttribute(
					"EmailAddress",
					request.getParameter("EmailAddress"));
				session.setAttribute(
					"InternalPhone",
					request.getParameter("InternalPhone"));
				session.setAttribute(
					"HomePhone",
					request.getParameter("HomePhone"));
				session.setAttribute(
					"MobilePhone",
					request.getParameter("MobilePhone"));
				session.setAttribute(
					"MSN",
					request.getParameter("MSN"));
				session.setAttribute(
					"HomeAddress",
					request.getParameter("HomeAddress"));
				if (new Integer(request.getParameter("BirthdayDay"))
					.intValue()
					< 10) {
					session.setAttribute(
						"Birthday",
						request.getParameter("BirthdayYear")
							+ "-"
							+ request.getParameter("BirthdayMonth")
							+ "-0"
							+ request.getParameter("BirthdayDay"));
				}
				else {
					session.setAttribute(
						"Birthday",
						request.getParameter("BirthdayYear")
							+ "-"
							+ request.getParameter("BirthdayMonth")
							+ "-"
							+ request.getParameter("BirthdayDay"));
				}
				//更新用户个人信息
				stmt.executeUpdate(
					"update PSLogins set Password='"
						+ new MD5().getMD5ofStr(
							request.getParameter("NewPassword"))
						+ "',EmailAddress='"
						+ request.getParameter("EmailAddress")
						+ "',  InternalPhone='"
						+ request.getParameter("InternalPhone")
						+ "',HomePhone='"
						+ request.getParameter("HomePhone")
						+ "', MobilePhone='"
						+ request.getParameter("MobilePhone")
						+ "', MSN='"
						+ request.getParameter("MSN")
						+ "',HomeAddress='"
						+ request.getParameter("HomeAddress")
						+ "',Birthday='"
						+ request.getParameter("BirthdayYear")
						+ "-"
						+ request.getParameter("BirthdayMonth")
						+ "-"
						+ request.getParameter("BirthdayDay")
						+ "' Where Name='"
						+ request.getParameter("Name")
						+ "'");
				TheMessage = "您的个人信息已经修改成功";
			}
			else {
				TheMessage = "新密码输入不一致，请重试";
			}
		}
	}
	else {
		TheMessage = "您输入的密码有误，请重试";
	}
}
else {
	TheMessage = "请在下面修改您的个人信息";
}
String Birthday = (String)session.getAttribute("Birthday");
%>



<HTML>
<HEAD>
<TITLE>修改个人信息</TITLE>
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
		公司办公信息管理系统->员工信息管理系统->修改我的个人信息&nbsp[当前用户- <%=session.getAttribute("Name")%>
		] </font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="../html/home.jsp"><font color="#104DAD">返回系统主页</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href="employeeinformation.jsp"><font
			color="#104DAD">返回上一级网页</font></a></td>
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

<br>

<FORM ACTION="modifypersonalinformation.jsp" METHOD=POST>
<TABLE CELLPADDING=1 CELLSPACING=1 BORDER=1 bordercolor="#164DA8"
	WIDTH=800 align=center>
	<TR VALIGN="middle" ALIGN="center">

		<TD WIDTH=30% bgcolor=#B5C7EF>
		<P><img src="../image/employee1.jpg">
		</td>
		<td><br>
		<table CELLPADDING=0 CELLSPACING=1 BORDER=0 align=center width=100%>
			<tr>
				<td width=25%><font color="#164DA8">姓名</font></td>
				<td><INPUT TYPE="text" NAME="Name"
					VALUE="<%=session.getAttribute("Name")%>" SIZE=51 MAXLENGTH=50
					readonly="true"></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">电子邮件地址</font></td>
				<td><INPUT TYPE="text" NAME="EmailAddress"
					VALUE="<%=session.getAttribute("EmailAddress")%>" SIZE=51
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">内部分机电话</font></td>
				<td><INPUT TYPE="text" NAME="InternalPhone"
					VALUE="<%=session.getAttribute("InternalPhone")%>" SIZE=51
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">移动电话</font></td>
				<td><INPUT TYPE="text" NAME="MobilePhone"
					VALUE="<%=session.getAttribute("MobilePhone")%>" SIZE=51
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">家庭电话</font></td>
				<td><INPUT TYPE="text" NAME="HomePhone"
					VALUE="<%=session.getAttribute("HomePhone")%>" SIZE=51 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">MSN</font></td>
				<td><INPUT TYPE="text" NAME="MSN"
					VALUE="<%=session.getAttribute("MSN")%>" SIZE=51 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">生日</font></td>
				<td><select name="BirthdayYear" size=1>
					<%int YearCounter = new Integer(Birthday.substring(0, 4)).intValue();%>
					<option value="<%=YearCounter%>"><%=YearCounter%></option>
					<%for (YearCounter = 2000; YearCounter >= 1900; YearCounter--) {%>
					<OPTION VALUE="<%=YearCounter%>"><%=YearCounter%></OPTION>
					<%}%>
				</select> 年 <select name="BirthdayMonth" size=1>
					<%int MonthCounter =
	new Integer(Birthday.substring(5, Birthday.lastIndexOf('-')))
		.intValue();%>
					<option value="<%=MonthCounter%>"><%=MonthCounter%></option>
					<%for (MonthCounter = 1; MonthCounter <= 12; MonthCounter++) {%>
					<OPTION VALUE="<%=MonthCounter%>"><%=MonthCounter%></OPTION>
					<%}%>
				</select> 月 <select name="BirthdayDay" size=1>
					<%int DayCounter =
	new Integer(
		Birthday.substring(
			Birthday.lastIndexOf('-') + 1,
			Birthday.lastIndexOf('-') + 3))
		.intValue();%>
					<option value="<%=DayCounter%>"><%=DayCounter%></option>
					<%for (DayCounter = 1; DayCounter <= 31; DayCounter++) {%>
					<OPTION VALUE="<%=DayCounter%>"><%=DayCounter%></OPTION>
					<%}%>
				</select> 日</td>
			</tr>

			<tr>
				<td width=25%><font color="#164DA8">家庭住址</font></td>
				<td><INPUT TYPE="text" NAME="HomeAddress"
					VALUE="<%=session.getAttribute("HomeAddress")%>" SIZE=51
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">请输入您的密码</font></td>
				<td><INPUT TYPE="Password" NAME="Password" VALUE="" SIZE=51
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">请输入您的新密码</font></td>
				<td><INPUT TYPE="Password" NAME="NewPassword" VALUE="" SIZE=51
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">请确认您的新密码</font></td>
				<td><INPUT TYPE="Password" NAME="ConfirmNewPassword" VALUE=""
					SIZE=51 MAXLENGTH=50></td>
			</tr>
		</table>
		<br>
		</td>
	</TR>
</table>

<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=1 WIDTH=800 align=center>
	<TR VALIGN="top" ALIGN="center">
		<TD WIDTH=100% align=center><INPUT TYPE="submit" NAME="Send"
			VALUE="修改个人信息"
			style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB"></TD>

	</TR>
</table>

</FORM>

</body>
</html>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
