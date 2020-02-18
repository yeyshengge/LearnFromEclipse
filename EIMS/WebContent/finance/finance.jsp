<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%String TheMessage = "";
//判断用户是否登录
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//连接系统数据库
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//用户提交了表单
if (request.getParameter("Send") != null) {
	//用户选择了添加财务记录选项
	if (request
		.getParameter("SendTo")
		.equals("AddFinancialRecord")) {
		if (session
			.getAttribute("IsFinancialManager")
			.equals("True")) {
			response.sendRedirect("addfinancialrecord.jsp");
		}
		else {
			TheMessage = "您不是财务管理员，无权进入此选项";
		}
	}
	//用户选择了财务报表选项
	else if (
		request.getParameter("SendTo").equals("FinancialReport")) {
		response.sendRedirect("financialreport.jsp");
	}
	//用户选择了修改财务记录选项
	else {
		if (session
			.getAttribute("IsFinancialManager")
			.equals("True")) {
			response.sendRedirect("modifyfinancialrecord.jsp");
		}
		else {
			TheMessage = "您不是财务管理员，无权进入此选项";
		}
	}
}
else {
	TheMessage = "请选择您要进行的财务信息管理功能模块";
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
		公司办公信息管理系统->财务信息管理子系统&nbsp[当前用户- <%=session.getAttribute("Name")%>
		] </font></div>
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

<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="3" cellspacing="0">
	<tr>
		<td>

		<FORM ACTION="finance.jsp" METHOD=POST><br>

		<TABLE CELLPADDING=1 CELLSPACING=2 BORDER=1 bordercolor="#164DA8"
			WIDTH=800 align=center>
			<TR VALIGN="middle" ALIGN="center">
				<TD WIDTH=35% bgcolor=#B5C7EF><img src="../image/finance1.jpg"></td>
				<td>

				<table border=1 width=100%>
					<tr height=30 align=center>
						<td><input type=radio checked name=SendTo value=AddFinancialRecord></td>
						<td><font color="#104DAD">财务信息管理子系统</font> -&nbsp<font
							color="#104DAD">添加财务记录</font></td>
					</tr>
					<tr height=30 align=center>
						<td><input type=radio name=SendTo value=FinancialReport></td>
						<td><font color="#104DAD">财务信息管理子系统</font> -&nbsp<font
							color="#104DAD">生成财务报表</font></td>
					</tr>
					<tr height=30 align=center>
						<td><input type=radio name=SendTo value=ModifyFinancialRecord></td>
						<td><font color="#104DAD">财务信息管理子系统</font> -&nbsp<font
							color="#104DAD">修改财务记录</font></td>
					</tr>
					<tr height=30 align=center>
						<td colspan=3><INPUT TYPE="submit" NAME="Send" VALUE="进入选项"
							style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB"></td>
					</tr>
				</table>
				注意：添加和修改财务记录需要财务管理员身份，否则不准进入！</td>
			</TR>
		</table>
		</FORM>
</BODY>
</HTML>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
