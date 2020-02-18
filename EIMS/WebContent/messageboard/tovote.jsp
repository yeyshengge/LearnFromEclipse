<%@ page contentType="text/html; charset=gb2312" language="java"  %>
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
ResultSet RSVerify = null;
String EmailMessage = "";
ResultSet RSQuestion = null;
ResultSet RSVoteSender = null;
ResultSet RSResultsTo = null;
ResultSet RSYesVotes = null;
ResultSet RSNoVotes = null;
ResultSet RSUnknownVotes = null;
String SenderName = "";
String Question = "";
//连接系统数据库
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//判断用户是否具有合法的身份第一次链接到此页面
if (request.getParameter("QuestionID") != null
	&& request.getParameter("VoterID") != null
	&& request.getParameter("Vote") == null) {
	TheMessage = "请在下面进行投票";
	RSVerify =
		stmt.executeQuery(
			"Select vote from VotingVotes where QuestionID = "
				+ request.getParameter("QuestionID")
				+ " and VoterID ="
				+ request.getParameter("VoterID"));
	int i = 0;
	while (RSVerify.next()) {
		//若已经投票则自动退出
		if (RSVerify.getString("Vote") != null) {
			response.sendRedirect("../login.jsp");
		}
		i++;
	}
	if (i == 0) {
		//QuestionID和VoterID的组合非法，自动退出
		response.sendRedirect("../login.jsp");
	}

	RSQuestion =
		stmt.executeQuery(
			"Select SenderName, Subject, Question from VotingQuestions where QuestionID = "
				+ request.getParameter("QuestionID"));
	while (RSQuestion.next()) {
		SenderName = RSQuestion.getString("SenderName");
		Question = RSQuestion.getString("Question");
	}
}
//用户进行了投票
else if (request.getParameter("Vote") != null) {
	//查询出投票问题的具体内容
	RSQuestion =
		stmt.executeQuery(
			"Select SenderName, Subject, Question, VoterNumber from VotingQuestions where QuestionID = "
				+ request.getParameter("QuestionID"));
	while (RSQuestion.next()) {
		EmailMessage = "您发布的投票现在有了新结果了! 下面是最新的结果: " + "\n\r";
		EmailMessage =
			EmailMessage
				+ "投票问题ID: "
				+ request.getParameter("QuestionID")
				+ "\n\r";
		EmailMessage =
			EmailMessage
				+ "投票问题题目: "
				+ RSQuestion.getString("Subject")
				+ "\n\r";
		EmailMessage =
			EmailMessage
				+ "投票问题内容: "
				+ RSQuestion.getString("Question")
				+ "\n\r";
		EmailMessage =
			EmailMessage
				+ "总共应投票人数: "
				+ RSQuestion.getInt("VoterNumber")
				+ "\n\r";
	}
	//更新投票问题的投票结果
	stmt.executeUpdate(
		"update VotingVotes set Vote = '"
			+ request.getParameter("VoteResponse")
			+ "' where QuestionID = "
			+ request.getParameter("QuestionID")
			+ " and VoterID = "
			+ request.getParameter("VoterID"));
	RSYesVotes =
		stmt.executeQuery(
			"SELECT COUNT(VoterID) AS VoteYes FROM VotingVotes WHERE QuestionID = "
				+ request.getParameter("QuestionID")
				+ " AND Vote = 'Yes'");
	int VoteYes = 0;
	while (RSYesVotes.next()) {
		VoteYes = RSYesVotes.getInt("VoteYes");
	}
	RSNoVotes =
		stmt.executeQuery(
			"SELECT COUNT(VoterID) AS VoteNo FROM VotingVotes WHERE QuestionID = "
				+ request.getParameter("QuestionID")
				+ " AND Vote = 'No'");
	int VoteNo = 0;
	while (RSNoVotes.next()) {
		VoteNo = RSNoVotes.getInt("VoteNo");
	}
	RSUnknownVotes =
		stmt.executeQuery(
			"SELECT COUNT(VoterID) AS VoteUnknown FROM VotingVotes WHERE QuestionID = "
				+ request.getParameter("QuestionID")
				+ " AND Vote = 'Unknown'");
	int VoteUnknown = 0;
	while (RSUnknownVotes.next()) {
		VoteUnknown = RSUnknownVotes.getInt("VoteUnknown");
	}
	int HaveVote = VoteYes + VoteNo + VoteUnknown;
	EmailMessage = EmailMessage + "现已投票人数 " + HaveVote + "\n\r";
	EmailMessage = EmailMessage + "是: " + VoteYes + "\n\r";
	EmailMessage = EmailMessage + "否: " + VoteNo + "\n\r";
	EmailMessage = EmailMessage + "说不清: " + VoteUnknown + "\n\r";
	RSVoteSender =
		stmt.executeQuery(
			"select SenderName from VotingQuestions where QuestionID="
				+ request.getParameter("QuestionID"));
	while (RSVoteSender.next()) {
		SenderName = RSVoteSender.getString("SenderName");
	}
	RSResultsTo =
		stmt.executeQuery(
			"select EmailAddress from PSLogins where Name='"
				+ SenderName
				+ "'");
	while (RSResultsTo.next()) {
		try {
			Properties props = new Properties(); //创建属性对象
			Session sendMailSession; //创建对话对象
			Store store;
			Transport transport; //创建传输对象
			PopupAuthenticator popAuthenticator =
				new PopupAuthenticator();
			PasswordAuthentication pop =
				popAuthenticator.performCheck("zhaoruyi", "euyi8401");
			sendMailSession = Session.getInstance(props, null);
			//对话目标
			props.put("mail.smtp.host", "smtp.nlsde.buaa.edu.cn");
			//设置对话对象
			props.put("mail.smtp.auth", "true"); //设置smtp身份认证
			Message newMessage = new MimeMessage(sendMailSession);
			//创建信息对象
			//newMessage.setFrom(new InternetAddress((String)session.getAttribute("EmailAddress")));
			newMessage.setFrom(new InternetAddress("eims@eims.com"));
			//发送者
			newMessage.setRecipient(
				Message.RecipientType.TO,
				new InternetAddress(
					RSResultsTo.getString("EmailAddress")));
			//接受者
			newMessage.setSubject("最新的投票结果"); //邮件主题
			newMessage.setSentDate(new java.util.Date()); //发送日期
			newMessage.setText(EmailMessage); //邮件内容
			transport = sendMailSession.getTransport("smtp");
			//实例化传输对象
			Transport.send(newMessage); //发送邮件
		}
		catch (MessagingException m) {
			System.err.println(m.toString());
			TheMessage = "您的投票已提交成功,但通知邮件未能正常发送！";
		}
	}
	response.sendRedirect("voting.jsp");
}
else {
	response.sendRedirect("voting.jsp");
}
%>

<HTML>
<HEAD>
<TITLE>公司内部意见箱-参与投票</TITLE>
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
		<div align="center"><font color=white>公司办公信息管理系统->内部信息交流系统->进行投票&nbsp[当前用户-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td align=left><a href=".././html/home.jsp"><font color="#104DAD">返回系统主页</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href=javascript:parent.close();><font
			color="#104DAD">退出投票页面</font></a></td>
	</tr>
</table>
<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="13"><img src=".././image/banner2.jpg" width="800"
			height="12"></td>
	</tr>
</table>

<form action="tovote.jsp" method=post>
<TABLE CELLPADDING=1 CELLSPACING=2 BORDER=1 bordercolor="#164DA8"
	WIDTH=800 align=center>
	<TR VALIGN="middle" ALIGN="center">
		<TD WIDTH=35% bgcolor=#B5C7EF><img src="../image/messageboard1.jpg"></td>
		<td valign=top>
		<table width=100% border=0 bgcolor=#B5C7EF cellspacing=1 cellpadding=2>
			<tr>
				<td><INPUT TYPE=HIDDEN NAME="QuestionID"
					VALUE="<%=request.getParameter("QuestionID")%>"> <INPUT TYPE=Hidden
					NAME="VoterID" VALUE="<%=request.getParameter("VoterID")%>"></td>

			</tr>
			<tr>
				<td colspan=2 height=30 align=center>本次投票详细信息</td>
			</tr>
			<tr bgcolor=white>
				<td width=35% height=30>投票问题ID</td>
				<td><%=request.getParameter("QuestionID")%></td>
			</tr>
			<tr bgcolor=white>
				<td height=30>举办投票者姓名</td>
				<td><%=SenderName%></td>
			</tr>
			<tr bgcolor=white>
				<td height=30>投票者ID</td>
				<td><%=request.getParameter("VoterID")%></td>
			</tr>
			<tr bgcolor=white>
				<td height=30>投票问题的内容</td>
				<td>
				<table bgcolor=black width=100% cellspacing=1 cellpadding=2>
					<tr bgcolor=white>
						<td><%=Question%></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr bgcolor=white>
				<td height=30>投票选项</td>
				<td><SELECT NAME="VoteResponse">
					<OPTION VALUE="Yes" SELECTED>&nbsp&nbsp&nbsp 是 &nbsp&nbsp&nbsp</OPTION>
					<OPTION VALUE="No">&nbsp&nbsp&nbsp 否 &nbsp&nbsp&nbsp</OPTION>
					<OPTION VALUE="Unknown">&nbsp&nbsp说不清&nbsp&nbsp</OPTION>
				</SELECT></td>
			</tr>
			<tr bgcolor=white>
				<td colspan=2 align=center>请注意,您只能有一次投票机会。</td>
			</tr>
			<tr bgcolor=white>
				<td colspan=2 align=center><INPUT TYPE="submit" NAME="Vote"
					VALUE="进行投票"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
