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
//�ж��û��Ƿ�ӵ�кϷ�����������
if (request.getParameter("SuggestionID") == null
	&& request.getQueryString().indexOf("SuggestionID") == -1) {
	response.sendRedirect("../login.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//����û��ӵ����ʼ����ӵ���ҳ��
if (request.getQueryString() != null
	&& request.getQueryString().indexOf("SuggestionID") != -1) {
	CurrentSuggestID =
		new Integer(request.getParameter("SuggestionID")).intValue();
	TheMessage = "������������������";
}
else {
	//����û������������
	CurrentSuggestID =
		new Integer(request.getParameter("SuggestionID")).intValue();
	//У���û����������
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
					+ "' and Position='����'");
		while (RSCommentor.next()) {
			temp = RSCommentor.getString("LoginID");
			temp2 = RSCommentor.getString("Password");
		}
		//�ж��û��Ƿ���Ȩ����
		if (request.getParameter("CommentorName").equals(temp)
			&& new MD5()
				.getMD5ofStr(
					request.getParameter("CommentorPassword"))
				.equals(temp2)) {
			stmt.executeUpdate(
				"update SuggestionRecords set Status = '�Ѵ���', Comments = '"
					+ request.getParameter("Comments")
					+ "' where SuggestionID = "
					+ request.getParameter("SuggestionID"));
			TheMessage = "�������Ĵ����������ɹ�";
		}
		else {
			TheMessage = "����Ȩ�������������������ģ�����������������������Ƿ���ȷ";
			Warning = true;
		}
	}
	else {
		TheMessage = "�������Ļظ�������ݲ���Ϊ��";
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
<TITLE>��˾�ڲ������-�����������</TITLE>
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
		<div align="center"><font color=white>��˾�칫��Ϣ����ϵͳ->�ڲ���Ϣ����ϵͳ->���������->�����������&nbsp[��ǰ�û�-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td align=left><a href=".././html/home.jsp"><font color="#104DAD">����ϵͳ��ҳ</font></a></td>
		<td align=center><%if (Warning == false) {%> <font color="#104DAD"><%=TheMessage%></FONT>
		<%}
else {%> <font color=red><%=TheMessage%></FONT> <%}%></td>
		<td align=right><a href=javascript:parent.close();><font
			color="#104DAD">�˳��������ҳ��</font></a></td>
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
				<td width=30%>�����</td>
				<td><%=CurrentSuggestID%></td>
			</tr>
			<tr>
				<td>����ύ������</td>
				<td><%=SenderName%></td>
			</tr>
			<tr>
				<td>�����������</td>
				<td><%=ToDepartment%></td>
			</tr>
			<tr>
				<td>�������</td>
				<td><%=SuggestionType%></td>
			</tr>
			<tr>
				<td>�������</td>
				<td><%=TextofSuggestion%></td>
			</tr>
			<tr>
				<td>���״̬</td>
				<td><%=CurrentStatus%></td>
			</tr>
			<tr>
				<td>�ظ����</td>
				<td><TEXTAREA NAME="Comments" rows=10 cols=50><%=CurrentComments%></TEXTAREA></td>
			</tr>
			<tr>
				<td>���ĵ�¼��</td>
				<td><Input type=text NAME="CommentorName" Maxlength=50></td>
			</tr>
			<tr>
				<td>���ĵ�¼����</td>
				<td><Input type=password NAME="CommentorPassword" Maxlength=50></td>
			</tr>
			<tr>
				<td colspan=2 align=center><input type=submit name=SubmitChanges
					value="�ύ�������"
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
