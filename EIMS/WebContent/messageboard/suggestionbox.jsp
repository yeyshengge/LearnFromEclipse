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
//�ж��û��Ƿ��¼
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//����û�Ҫ�鿴�Լ����������Ĵ�����
if (request.getParameter("Review") != null) {
	SqlReview =
		"select * from SuggestionRecords where SenderName='"
			+ session.getAttribute("Name")
			+ "' and Status='�Ѵ���' order by WhenSent DESC";
	RSReviewSuggestion = stmt.executeQuery(SqlReview);
	ReviewLabel = true;
	TheMessage = "�����ύ�����Ŀǰ�Ѿ�����Ľ������";
}
//����û��ύ���������
else if (request.getParameter("OK") != null) {
	//�����������������ݿ�
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
			+ "','δ����')";
	stmt.executeUpdate(SqlString);
	//������ύ��������������
	ResultSet RSSuggestionID =
		stmt.executeQuery(
			"select SuggestionID from SuggestionRecords where WhenSent = '"
				+ CurrentTime
				+ "'");
	//��������ʼ�������
	EmailMessage = "�����������: " + session.getAttribute("Name") + "\n\r";
	EmailMessage =
		EmailMessage
			+ "�������: "
			+ request.getParameter("SuggestionType")
			+ "\n\r";
	EmailMessage =
		EmailMessage
			+ "�������: "
			+ request.getParameter("SuggestionText")
			+ "\n\r";
	EmailMessage = EmailMessage + "��Ҫ��������������飬�������������:\n\r";
	EmailMessage =
		EmailMessage
			+ "http://192.168.2.6:8080/EIMS/messageboard/analysis.jsp?SuggestionID=";
	while (RSSuggestionID.next()) {
		EmailMessage += RSSuggestionID.getInt("SuggestionID");
	}
	//���Ҫ������鷢������ĵ����ʼ���ַ
	ResultSet RSEmails =
		stmt.executeQuery(
			"Select EmailAddress  from PSLogins where Department='"
				+ request.getParameter("ToDepartment")
				+ "' and Position='����'");
	//�����ж����͵����ʼ�
	while (RSEmails.next()) {
		try {
			Properties props = new Properties(); //�������Զ���
			Session sendMailSession; //�����Ի�����
			Store store;
			Transport transport; //�����������
			PopupAuthenticator popAuthenticator =
				new PopupAuthenticator();
			PasswordAuthentication pop =
				popAuthenticator.performCheck("zhaoruyi", "euyi8401");
			sendMailSession =
				Session.getInstance(props, popAuthenticator);
			//�Ի�Ŀ��
			props.put("mail.smtp.host", "smtp.nlsde.buaa.edu.cn");
			//���öԻ�����
			props.put("mail.smtp.auth", "true"); //����smtp�����֤
			Message newMessage = new MimeMessage(sendMailSession);
			//������Ϣ����
			//newMessage.setFrom(
			//new InternetAddress(
			//(String)session.getAttribute("EmailAddress")));
			newMessage.setFrom(new InternetAddress("eims@eims.com"));
			//������
			newMessage.setRecipient(
				Message.RecipientType.TO,
				new InternetAddress(
					RSEmails.getString("EmailAddress")));
			//������
			newMessage.setSubject("�µ��������Ϣ!");
			//�ʼ�����
			newMessage.setSentDate(new java.util.Date()); //��������
			newMessage.setText(EmailMessage); //�ʼ�����
			transport = sendMailSession.getTransport("smtp");
			//ʵ�����������
			Transport.send(newMessage); //�����ʼ�
			TheMessage = "��������������ύ�ɹ�����������д���������";
		}
		catch (MessagingException m) {
			System.err.println(m);
			TheMessage = "��������������ύ�ɹ�,��֪ͨ�ʼ�δ���������ͣ�";
		}
	}
}
else {
	TheMessage = "����������д���Ľ������";
}
%>

<HTML>
<HEAD>
<TITLE>��˾�ڲ������-�ύ�������</TITLE>
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
		<div align="center"><font color=white>��˾�칫��Ϣ����ϵͳ->�ڲ���Ϣ����ϵͳ->���������&nbsp[��ǰ�û�-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href=".././html/home.jsp"><font color="#104DAD">����ϵͳ��ҳ</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href="communication.jsp"><font color="#104DAD">������һ����ҳ</font></a></td>
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
				<td>��ѡ����Ҫ������Ĳ���</td>
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
				<td>��ѡ����Ҫ�����������</td>
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
				<td>��ѡ����Ҫ�����������</td>
				<td><TEXTAREA NAME="SuggestionText" ROWS=6 COLS=40></TEXTAREA></td>
			</tr>
			<tr>
				<td colspan=2 align=center><input type=submit name=OK value="�ύ�ҵ����"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				<input type=reset name=reset value="�����ҵ����"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				<input type=submit name=Review value="�鿴�ҵ����"
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
		<td colspan=6 height=1><font color=white>���ύ���������Ŀǰ����������</font></td>
	</tr>
	<tr bgcolor=white>
		<td align=left>�����</td>
		<td align=left>��������</td>
		<td align=left>�������</td>
		<td align=left>�������</td>
		<td align=left>�ظ����</td>
		<td align=left>Ŀǰ״̬</td>
		<td align=left>��������</td>
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
