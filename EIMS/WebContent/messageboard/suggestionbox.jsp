<%@ page contentType="text/html; charset=gb2312" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.activation.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>
<%@ page import="cn.edu.buaa.nlsde.auth.PopupAuthenticator"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
boolean ReviewLabel = false;
String EmailMessage = "";
String temp = "";
String SqlReview = "";
ResultSet RSReviewSuggestion = null;
Calendar cal = Calendar.getInstance();
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String CurrentTime = format.format(cal.getTime());
//判断用户是否登录
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//连接系统数据库
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//如果用户要查看自己提出的意见的处理结果
if (request.getParameter("Review") != null) {
	SqlReview =
		"select * from SuggestionRecords where SenderName='"
			+ session.getAttribute("Name")
			+ "' and Status='已处理' order by WhenSent DESC";
	RSReviewSuggestion = stmt.executeQuery(SqlReview);
	ReviewLabel = true;
	TheMessage = "您所提交的意见目前已经处理的结果如下";
}
//如果用户提交新意见建议
else if (request.getParameter("OK") != null) {
	//将新意见建议插入数据库
	String SqlString =
		"Insert into SuggestionRecords (SenderName, ToDepartment, SuggestionType, SuggestionText, WhenSent, Status) values ('"
			+ session.getAttribute("Name")
			+ "','"
			+ request.getParameter("ToDepartment")
			+ "','"
			+ request.getParameter("SuggestionType")
			+ "','"
			+ request.getParameter("SuggestionText")
			+ "','"
			+ CurrentTime
			+ "','未处理')";
	stmt.executeUpdate(SqlString);
	//查出刚提交的意见建议的内容
	ResultSet RSSuggestionID =
		stmt.executeQuery(
			"select SuggestionID from SuggestionRecords where WhenSent = '"
				+ CurrentTime
				+ "'");
	//构造电子邮件的内容
	EmailMessage = "意见建议来自: " + session.getAttribute("Name") + "\n\r";
	EmailMessage =
		EmailMessage
			+ "意见类型: "
			+ request.getParameter("SuggestionType")
			+ "\n\r";
	EmailMessage =
		EmailMessage
			+ "意见内容: "
			+ request.getParameter("SuggestionText")
			+ "\n\r";
	EmailMessage = EmailMessage + "想要处理这条意见建议，请点击下面的链接:\n\r";
	EmailMessage =
		EmailMessage
			+ "http://192.168.2.6:8080/EIMS/messageboard/analysis.jsp?SuggestionID=";
	while (RSSuggestionID.next()) {
		EmailMessage += RSSuggestionID.getInt("SuggestionID");
	}
	//查出要意见建议发往对象的电子邮件地址
	ResultSet RSEmails =
		stmt.executeQuery(
			"Select EmailAddress  from PSLogins where Department='"
				+ request.getParameter("ToDepartment")
				+ "' and Position='主管'");
	//向所有对象发送电子邮件
	while (RSEmails.next()) {
		try {
			Properties props = new Properties(); //创建属性对象
			Session sendMailSession; //创建对话对象
			Store store;
			Transport transport; //创建传输对象
			PopupAuthenticator popAuthenticator =
				new PopupAuthenticator();
			PasswordAuthentication pop =
				popAuthenticator.performCheck("zhaoruyi", "euyi8401");
			sendMailSession =
				Session.getInstance(props, popAuthenticator);
			//对话目标
			props.put("mail.smtp.host", "smtp.nlsde.buaa.edu.cn");
			//设置对话对象
			props.put("mail.smtp.auth", "true"); //设置smtp身份认证
			Message newMessage = new MimeMessage(sendMailSession);
			//创建信息对象
			//newMessage.setFrom(
			//new InternetAddress(
			//(String)session.getAttribute("EmailAddress")));
			newMessage.setFrom(new InternetAddress("eims@eims.com"));
			//发送者
			newMessage.setRecipient(
				Message.RecipientType.TO,
				new InternetAddress(
					RSEmails.getString("EmailAddress")));
			//接受者
			newMessage.setSubject("新的意见箱消息!");
			//邮件主题
			newMessage.setSentDate(new java.util.Date()); //发送日期
			newMessage.setText(EmailMessage); //邮件内容
			transport = sendMailSession.getTransport("smtp");
			//实例化传输对象
			Transport.send(newMessage); //发送邮件
			TheMessage = "您的意见建议已提交成功，您可以填写新意见建议";
		}
		catch (MessagingException m) {
			System.err.println(m);
			TheMessage = "您的意见建议已提交成功,但通知邮件未能正常发送！";
		}
	}
}
else {
	TheMessage = "请在下面填写您的建议意见";
}
%>

<HTML>
<HEAD>
<TITLE>公司内部意见箱-提交意见建议</TITLE>
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
		<div align="center"><font color=white>公司办公信息管理系统->内部信息交流系统->意见建议箱&nbsp[当前用户-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href=".././html/home.jsp"><font color="#104DAD">返回系统主页</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href="communication.jsp"><font color="#104DAD">返回上一级网页</font></a></td>
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

<TABLE CELLPADDING=1 CELLSPACING=2 BORDER=1 bordercolor="#164DA8"
	WIDTH=800 align=center>
	<TR VALIGN="middle" ALIGN="center">
		<TD WIDTH=35% bgcolor=#B5C7EF><img src="../image/messageboard1.jpg"></td>
		<td>

		<FORM ACTION="suggestionbox.jsp" METHOD=POST>
		<table width=100% border=1>
			<tr height=30>
				<td>请选择您要提意见的部门</td>
				<td><SELECT NAME="ToDepartment">
					<%ResultSet RSDepartments =
	stmt.executeQuery(
		"select * from Departments order by DepartmentName");
while (RSDepartments.next()) {
	temp = RSDepartments.getString("DepartmentName");%>
					<OPTION VALUE="<%=temp%>"><%=temp%></OPTION>
					<%}%>
				</select></td>
			</tr>
			<tr>
				<td>请选择您要提意见的类型</td>
				<td><SELECT NAME="SuggestionType">
					<%ResultSet RSTypes =
	stmt.executeQuery(
		"select * from SuggestionTypes order by SuggestionType");
while (RSTypes.next()) {
	temp = RSTypes.getString("SuggestionType");%>
					<OPTION VALUE="<%=temp%>"><%=temp%></OPTION>
					<%}%>
				</SELECT></td>
			</tr>
			<tr>
				<td>请选择您要提意见的内容</td>
				<td><TEXTAREA NAME="SuggestionText" ROWS=6 COLS=40></TEXTAREA></td>
			</tr>
			<tr>
				<td colspan=2 align=center><input type=submit name=OK value="提交我的意见"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				<input type=reset name=reset value="重设我的意见"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				<input type=submit name=Review value="查看我的意见"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				</td>
			</tr>
		</table>
		</form>

		</td>
	</tr>
</table>

<%if (ReviewLabel == true) {%>
<table WIDTH=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>
	<tr>
		<td colspan=6 height=1><font color=white>您提交的意见建议目前处理结果如下</font></td>
	</tr>
	<tr bgcolor=white>
		<td align=left>意见号</td>
		<td align=left>发往部门</td>
		<td align=left>意见类型</td>
		<td align=left>意见内容</td>
		<td align=left>回复意见</td>
		<td align=left>目前状态</td>
		<td align=left>发送日期</td>
	</tr>
	<%RSReviewSuggestion = stmt.executeQuery(SqlReview);
while (RSReviewSuggestion.next()) {%>
	<TR bgcolor=white VALIGN="top" ALIGN="left">
		<TD><font face=arial><%=RSReviewSuggestion.getInt(1)%></font></TD>
		<TD><font face=arial><%=RSReviewSuggestion.getString(3)%></font></TD>
		<TD><font face=arial><%=RSReviewSuggestion.getString(4)%></font></TD>
		<TD><font face=arial><%=RSReviewSuggestion.getString(5)%></font></TD>
		<TD><font face=arial><%=RSReviewSuggestion.getString(6)%></font></TD>
		<TD><font face=arial><%=RSReviewSuggestion.getString(7)%></font></TD>
		<TD><font face=arial><%=RSReviewSuggestion.getString(8).substring(0, 10)%></font></TD>
	</TR>
	<%}%>
</table>
<%}%>
</body>
</html>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
