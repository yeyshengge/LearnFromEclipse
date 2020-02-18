<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>
<%@ page import="cn.edu.buaa.nlsde.md5.MD5"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
boolean Warning = false;
int CurrentSuggestID = 0;
String SenderName = "";
String ToDepartment = "";
String SuggestionType = "";
String TextofSuggestion = "";
String CurrentStatus = "";
String CurrentComments = "";
String temp = "";
String temp2 = "";
ResultSet RSSuggestion = null;
//判断用户是否拥有合法的意见建议号
if (request.getParameter("SuggestionID") == null
	&& request.getQueryString().indexOf("SuggestionID") == -1) {
	response.sendRedirect("../login.jsp");
}
//连接系统数据库
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//如果用户从电子邮件链接到此页面
if (request.getQueryString() != null
	&& request.getQueryString().indexOf("SuggestionID") != -1) {
	CurrentSuggestID =
		new Integer(request.getParameter("SuggestionID")).intValue();
	TheMessage = "请在下面进行意见批阅";
}
else {
	//如果用户批阅意见建议
	CurrentSuggestID =
		new Integer(request.getParameter("SuggestionID")).intValue();
	//校验用户输入的批阅
	if (!request.getParameter("Comments").trim().equals("")) {
		RSSuggestion =
			stmt.executeQuery(
				"select * from SuggestionRecords where SuggestionID="
					+ CurrentSuggestID);
		while (RSSuggestion.next()) {
			temp = RSSuggestion.getString("ToDepartment");
		}
		ResultSet RSCommentor =
			stmt.executeQuery(
				"select * from PSLogins where Department='"
					+ temp
					+ "' and Position='主管'");
		while (RSCommentor.next()) {
			temp = RSCommentor.getString("LoginID");
			temp2 = RSCommentor.getString("Password");
		}
		//判断用户是否有权批阅
		if (request.getParameter("CommentorName").equals(temp)
			&& new MD5()
				.getMD5ofStr(
					request.getParameter("CommentorPassword"))
				.equals(temp2)) {
			stmt.executeUpdate(
				"update SuggestionRecords set Status = '已处理', Comments = '"
					+ request.getParameter("Comments")
					+ "' where SuggestionID = "
					+ request.getParameter("SuggestionID"));
			TheMessage = "您已批阅此条意见建议成功";
		}
		else {
			TheMessage = "您无权对这条意见建议进行批阅，请检查您输入的姓名和密码是否正确";
			Warning = true;
		}
	}
	else {
		TheMessage = "意见建议的回复意见内容不能为空";
		Warning = true;
	}
	CurrentSuggestID =
		new Integer(request.getParameter("SuggestionID")).intValue();
}
RSSuggestion =
	stmt.executeQuery(
		"select * from SuggestionRecords where SuggestionID="
			+ CurrentSuggestID);
while (RSSuggestion.next()) {
	SenderName = RSSuggestion.getString("SenderName");
	ToDepartment = RSSuggestion.getString("ToDepartment");
	SuggestionType = RSSuggestion.getString("SuggestionType");
	TextofSuggestion = RSSuggestion.getString("SuggestionText");
	CurrentStatus = RSSuggestion.getString("Status");
	CurrentComments = RSSuggestion.getString("Comments");
}
%>


<HTML>
<HEAD>
<TITLE>公司内部意见箱-处理意见建议</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</HEAD>
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
		<div align="center"><font color=white>公司办公信息管理系统->内部信息交流系统->意见建议箱->批阅意见建议&nbsp[当前用户-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td align=left><a href=".././html/home.jsp"><font color="#104DAD">返回系统主页</font></a></td>
		<td align=center><%if (Warning == false) {%> <font color="#104DAD"><%=TheMessage%></FONT>
		<%}
else {%> <font color=red><%=TheMessage%></FONT> <%}%></td>
		<td align=right><a href=javascript:parent.close();><font
			color="#104DAD">退出意见批阅页面</font></a></td>
	</tr>
</table>
<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="13"><img src=".././image/banner2.jpg" width="800"
			height="12"></td>
	</tr>
</table>

<TABLE CELLPADDING=1 CELLSPACING=2 BORDER=1 bordercolor="#164DA8"
	WIDTH=800 align=center>
	<TR VALIGN="middle" ALIGN="center">
		<TD WIDTH=35% bgcolor=#B5C7EF><img src="../image/messageboard1.jpg"></td>
		<td>
		<FORM ACTION="analysis.jsp" METHOD=POST><INPUT TYPE=HIDDEN
			NAME="SuggestionID" VALUE="<%=CurrentSuggestID%>">
		<table width=100% border=1>
			<tr>
				<td width=30%>意见号</td>
				<td><%=CurrentSuggestID%></td>
			</tr>
			<tr>
				<td>意见提交者姓名</td>
				<td><%=SenderName%></td>
			</tr>
			<tr>
				<td>意见提往部门</td>
				<td><%=ToDepartment%></td>
			</tr>
			<tr>
				<td>意见类型</td>
				<td><%=SuggestionType%></td>
			</tr>
			<tr>
				<td>意见内容</td>
				<td><%=TextofSuggestion%></td>
			</tr>
			<tr>
				<td>意见状态</td>
				<td><%=CurrentStatus%></td>
			</tr>
			<tr>
				<td>回复意见</td>
				<td><TEXTAREA NAME="Comments" rows=10 cols=50><%=CurrentComments%></TEXTAREA></td>
			</tr>
			<tr>
				<td>您的登录名</td>
				<td><Input type=text NAME="CommentorName" Maxlength=50></td>
			</tr>
			<tr>
				<td>您的登录密码</td>
				<td><Input type=password NAME="CommentorPassword" Maxlength=50></td>
			</tr>
			<tr>
				<td colspan=2 align=center><input type=submit name=SubmitChanges
					value="提交意见批阅"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				</td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
</table>
</BODY>
</HTML>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
