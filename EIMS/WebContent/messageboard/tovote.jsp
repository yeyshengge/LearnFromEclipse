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
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//�ж��û��Ƿ���кϷ�����ݵ�һ�����ӵ���ҳ��
if (request.getParameter("QuestionID") != null
	&& request.getParameter("VoterID") != null
	&& request.getParameter("Vote") == null) {
	TheMessage = "�����������ͶƱ";
	RSVerify =
		stmt.executeQuery(
			"Select vote from VotingVotes where QuestionID = "
				+ request.getParameter("QuestionID")
				+ " and VoterID ="
				+ request.getParameter("VoterID"));
	int i = 0;
	while (RSVerify.next()) {
		//���Ѿ�ͶƱ���Զ��˳�
		if (RSVerify.getString("Vote") != null) {
			response.sendRedirect("../login.jsp");
		}
		i++;
	}
	if (i == 0) {
		//QuestionID��VoterID����ϷǷ����Զ��˳�
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
//�û�������ͶƱ
else if (request.getParameter("Vote") != null) {
	//��ѯ��ͶƱ����ľ�������
	RSQuestion =
		stmt.executeQuery(
			"Select SenderName, Subject, Question, VoterNumber from VotingQuestions where QuestionID = "
				+ request.getParameter("QuestionID"));
	while (RSQuestion.next()) {
		EmailMessage = "��������ͶƱ���������½����! ���������µĽ��: " + "\n\r";
		EmailMessage =
			EmailMessage
				+ "ͶƱ����ID: "
				+ request.getParameter("QuestionID")
				+ "\n\r";
		EmailMessage =
			EmailMessage
				+ "ͶƱ������Ŀ: "
				+ RSQuestion.getString("Subject")
				+ "\n\r";
		EmailMessage =
			EmailMessage
				+ "ͶƱ��������: "
				+ RSQuestion.getString("Question")
				+ "\n\r";
		EmailMessage =
			EmailMessage
				+ "�ܹ�ӦͶƱ����: "
				+ RSQuestion.getInt("VoterNumber")
				+ "\n\r";
	}
	//����ͶƱ�����ͶƱ���
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
	EmailMessage = EmailMessage + "����ͶƱ���� " + HaveVote + "\n\r";
	EmailMessage = EmailMessage + "��: " + VoteYes + "\n\r";
	EmailMessage = EmailMessage + "��: " + VoteNo + "\n\r";
	EmailMessage = EmailMessage + "˵����: " + VoteUnknown + "\n\r";
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
			Properties props = new Properties(); //�������Զ���
			Session sendMailSession; //�����Ի�����
			Store store;
			Transport transport; //�����������
			PopupAuthenticator popAuthenticator =
				new PopupAuthenticator();
			PasswordAuthentication pop =
				popAuthenticator.performCheck("zhaoruyi", "euyi8401");
			sendMailSession = Session.getInstance(props, null);
			//�Ի�Ŀ��
			props.put("mail.smtp.host", "smtp.nlsde.buaa.edu.cn");
			//���öԻ�����
			props.put("mail.smtp.auth", "true"); //����smtp�����֤
			Message newMessage = new MimeMessage(sendMailSession);
			//������Ϣ����
			//newMessage.setFrom(new InternetAddress((String)session.getAttribute("EmailAddress")));
			newMessage.setFrom(new InternetAddress("eims@eims.com"));
			//������
			newMessage.setRecipient(
				Message.RecipientType.TO,
				new InternetAddress(
					RSResultsTo.getString("EmailAddress")));
			//������
			newMessage.setSubject("���µ�ͶƱ���"); //�ʼ�����
			newMessage.setSentDate(new java.util.Date()); //��������
			newMessage.setText(EmailMessage); //�ʼ�����
			transport = sendMailSession.getTransport("smtp");
			//ʵ�����������
			Transport.send(newMessage); //�����ʼ�
		}
		catch (MessagingException m) {
			System.err.println(m.toString());
			TheMessage = "����ͶƱ���ύ�ɹ�,��֪ͨ�ʼ�δ���������ͣ�";
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
<TITLE>��˾�ڲ������-����ͶƱ</TITLE>
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
		<div align="center"><font color=white>��˾�칫��Ϣ����ϵͳ->�ڲ���Ϣ����ϵͳ->����ͶƱ&nbsp[��ǰ�û�-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td align=left><a href=".././html/home.jsp"><font color="#104DAD">����ϵͳ��ҳ</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href=javascript:parent.close();><font
			color="#104DAD">�˳�ͶƱҳ��</font></a></td>
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
				<td colspan=2 height=30 align=center>����ͶƱ��ϸ��Ϣ</td>
			</tr>
			<tr bgcolor=white>
				<td width=35% height=30>ͶƱ����ID</td>
				<td><%=request.getParameter("QuestionID")%></td>
			</tr>
			<tr bgcolor=white>
				<td height=30>�ٰ�ͶƱ������</td>
				<td><%=SenderName%></td>
			</tr>
			<tr bgcolor=white>
				<td height=30>ͶƱ��ID</td>
				<td><%=request.getParameter("VoterID")%></td>
			</tr>
			<tr bgcolor=white>
				<td height=30>ͶƱ���������</td>
				<td>
				<table bgcolor=black width=100% cellspacing=1 cellpadding=2>
					<tr bgcolor=white>
						<td><%=Question%></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr bgcolor=white>
				<td height=30>ͶƱѡ��</td>
				<td><SELECT NAME="VoteResponse">
					<OPTION VALUE="Yes" SELECTED>&nbsp&nbsp&nbsp �� &nbsp&nbsp&nbsp</OPTION>
					<OPTION VALUE="No">&nbsp&nbsp&nbsp �� &nbsp&nbsp&nbsp</OPTION>
					<OPTION VALUE="Unknown">&nbsp&nbsp˵����&nbsp&nbsp</OPTION>
				</SELECT></td>
			</tr>
			<tr bgcolor=white>
				<td colspan=2 align=center>��ע��,��ֻ����һ��ͶƱ���ᡣ</td>
			</tr>
			<tr bgcolor=white>
				<td colspan=2 align=center><INPUT TYPE="submit" NAME="Vote"
					VALUE="����ͶƱ"
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
