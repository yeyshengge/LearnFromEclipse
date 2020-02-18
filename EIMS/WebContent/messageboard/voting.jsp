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
ResultSet RSEmails = null;
ResultSet RSVoterNumber = null;
String EmailMessage = "";
String temp = "";
int VoterNumber = 0;
int QuestionID = 0;
int ID = 0;
String sql = "";
String sqlEmail = "";
//判断用户是否登录
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//连接系统数据库
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//开始发布投票
if (request.getParameter("Send") != null) {
	//投票发布的范围
	if (request.getParameter("SendTo").equals("All")) {
		RSVoterNumber =
			stmt.executeQuery(
				"SELECT COUNT(ID) AS VoterNumber FROM PSLogins ");
		while (RSVoterNumber.next()) {
			VoterNumber = RSVoterNumber.getInt("VoterNumber");
		}
		sqlEmail = "select ID, Name, EmailAddress from PSLogins";
	}
	else if (request.getParameter("SendTo").equals("Department")) {
		sql =
			"SELECT COUNT(ID) AS VoterNumber FROM PSLogins where Department = '"
				+ request.getParameter("DepartmentName")
				+ "'";
		RSVoterNumber = stmt.executeQuery(sql);
		while (RSVoterNumber.next()) {
			VoterNumber = RSVoterNumber.getInt("VoterNumber");
		}
		sqlEmail =
			"select ID, Name, EmailAddress from PSLogins where Department = '"
				+ request.getParameter("DepartmentName")
				+ "'";
	}
	else {
		RSVoterNumber =
			stmt.executeQuery(
				"SELECT COUNT(ID) AS VoterNumber FROM PSLogins where Position = '"
					+ request.getParameter("PositionName")
					+ "'");
		while (RSVoterNumber.next()) {
			VoterNumber = RSVoterNumber.getInt("VoterNumber");
		}
		sqlEmail =
			"select ID, Name, EmailAddress from PSLogins where Position = '"
				+ request.getParameter("PositionName")
				+ "'";
	}
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat format =
		new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String CurrentDateTime = format.format(cal.getTime());
	Statement stmt2 = conn.createStatement();
	sql =
		"Insert Into VotingQuestions (SenderName, Subject, Question, WhenSent, VoterNumber) values ('"
			+ session.getAttribute("Name")
			+ "','"
			+ request.getParameter("Subject")
			+ "','"
			+ request.getParameter("SuggestionText")
			+ "','"
			+ CurrentDateTime
			+ "',"
			+ VoterNumber
			+ ")";
	stmt.executeUpdate(sql);
	sql =
		"select QuestionID from VotingQuestions where WhenSent = '"
			+ CurrentDateTime
			+ "'";
	ResultSet RSQuestionID = stmt.executeQuery(sql);
	while (RSQuestionID.next()) {
		QuestionID = RSQuestionID.getInt("QuestionID");
	}
	RSEmails = stmt.executeQuery(sqlEmail);
	while (RSEmails.next()) {
		ID = RSEmails.getInt("ID");
		//构造电子邮件内容
		EmailMessage =
			session.getAttribute("Name") + "发起了一轮投票:" + "\n\r";
		EmailMessage =
			EmailMessage
				+ "投票的问题题目是:"
				+ request.getParameter("Subject")
				+ "\n\r";
		EmailMessage =
			EmailMessage
				+ "投票的问题内容是:"
				+ request.getParameter("SuggestionText")
				+ "\n\r";
		EmailMessage =
			EmailMessage
				+ "要想投票，请点击下面的链接(请注意，如果您已经投过票，您将无法看到链接):\n\r ";
		EmailMessage =
			EmailMessage
				+ "http://192.168.2.6:8080/EIMS/messageboard/tovote.jsp?";
		EmailMessage = EmailMessage + "QuestionID=" + QuestionID;
		EmailMessage = EmailMessage + "&VoterID=" + ID + "\n\r";
		sql =
			"insert into VotingVotes (QuestionID, VoterID, VoterName) values ("
				+ QuestionID
				+ ", "
				+ ID
				+ ", '"
				+ RSEmails.getString("Name")
				+ "')";
		stmt2.executeUpdate(sql);
		//发送投票通知的电子邮件
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
			newMessage.setSubject(request.getParameter("Subject"));
			//邮件主题
			newMessage.setSentDate(new java.util.Date()); //发送日期
			newMessage.setText(EmailMessage); //邮件内容
			transport = sendMailSession.getTransport("smtp");
			//实例化传输对象
			Transport.send(newMessage); //发送邮件			
			TheMessage = "您的投票调查已提交成功，您可以填写新投票调查";
		}
		catch (Exception m) {
			System.err.println(m.toString());
			TheMessage = "您的投票调查已提交成功,但通知邮件未能正常发送！";
		}
	}
}
else {
	TheMessage = "请在下面填写投票内容";
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
		<div align="center"><font color=white>
		公司办公信息管理系统->内部信息交流系统->投票站&nbsp[当前用户-<%=session.getAttribute("Name")%>]
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

<FORM ACTION="voting.jsp" METHOD=POST>
<TABLE CELLPADDING=1 CELLSPACING=2 BORDER=1 bordercolor="#164DA8"
	WIDTH=800 align=center>
	<TR VALIGN="middle" ALIGN="center">
		<TD WIDTH=35% bgcolor=#B5C7EF><img src="../image/messageboard1.jpg"></td>
		<td>
		<table width=100% border=1>
			<tr height=30>
				<td>请选择您发布投票的范围</td>
				<td>
				<table width=100% border=1>
					<tr>
						<td><INPUT TYPE="radio" CHECKED NAME="SendTo" VALUE="All">全体投票</td>
						<td><INPUT TYPE="radio" NAME="SendTo" VALUE="Department">部门投票</td>
						<td><INPUT TYPE="radio" NAME="SendTo" VALUE="Position">职位投票</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align=center><SELECT NAME="DepartmentName">
							<%ResultSet RSDepartments =
	stmt.executeQuery("select * from Departments");
while (RSDepartments.next()) {
	temp = RSDepartments.getString("DepartmentName");%>
							<OPTION VALUE="<%=temp%>"><%=temp%></OPTION>
							<%}%>
						</SELECT></td>
						<td align=center><SELECT NAME="PositionName">
							<%ResultSet PSPositions =
	stmt.executeQuery("select PositionName from Positions");
while (PSPositions.next()) {
	temp = PSPositions.getString("PositionName");%>
							<OPTION VALUE="<%=temp%>"><%=temp%></OPTION>
							<%}%>
						</SELECT></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>请选择您要进行投票的标题</td>
				<td><INPUT TYPE="text" NAME="Subject" VALUE="" SIZE=30 MAXLENGTH=30></td>
			</tr>
			<tr>
				<td>请选择您要进行投票的内容</td>
				<td><TEXTAREA NAME="SuggestionText" ROWS=6 COLS=40></TEXTAREA></td>
			</tr>
			<tr>
				<td colspan=2 align=center><input type=submit name=Send value="开始投票"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>

</BODY>
</HTML>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
