<%@ page contentType="text/html; charset=gb2312" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>
<%@ page import="cn.edu.buaa.nlsde.md5.MD5"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
//�ж��û��Ƿ��¼
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//����û��ύ�˱�
if (request.getParameter("Send") != null) {
	//�����û����У��
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
			//�����û�������Ϣ
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
			TheMessage = "���ĸ�����Ϣ�Ѿ��޸ĳɹ�";
		}
		else {
			//����û�������������
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
				//�����û�������Ϣ
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
				TheMessage = "���ĸ�����Ϣ�Ѿ��޸ĳɹ�";
			}
			else {
				TheMessage = "���������벻һ�£�������";
			}
		}
	}
	else {
		TheMessage = "���������������������";
	}
}
else {
	TheMessage = "���������޸����ĸ�����Ϣ";
}
String Birthday = (String)session.getAttribute("Birthday");
%>



<HTML>
<HEAD>
<TITLE>�޸ĸ�����Ϣ</TITLE>
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
		��˾�칫��Ϣ����ϵͳ->Ա����Ϣ����ϵͳ->�޸��ҵĸ�����Ϣ&nbsp[��ǰ�û�- <%=session.getAttribute("Name")%>
		] </font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="../html/home.jsp"><font color="#104DAD">����ϵͳ��ҳ</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href="employeeinformation.jsp"><font
			color="#104DAD">������һ����ҳ</font></a></td>
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
				<td width=25%><font color="#164DA8">����</font></td>
				<td><INPUT TYPE="text" NAME="Name"
					VALUE="<%=session.getAttribute("Name")%>" SIZE=51 MAXLENGTH=50
					readonly="true"></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�����ʼ���ַ</font></td>
				<td><INPUT TYPE="text" NAME="EmailAddress"
					VALUE="<%=session.getAttribute("EmailAddress")%>" SIZE=51
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�ڲ��ֻ��绰</font></td>
				<td><INPUT TYPE="text" NAME="InternalPhone"
					VALUE="<%=session.getAttribute("InternalPhone")%>" SIZE=51
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">�ƶ��绰</font></td>
				<td><INPUT TYPE="text" NAME="MobilePhone"
					VALUE="<%=session.getAttribute("MobilePhone")%>" SIZE=51
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">��ͥ�绰</font></td>
				<td><INPUT TYPE="text" NAME="HomePhone"
					VALUE="<%=session.getAttribute("HomePhone")%>" SIZE=51 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">MSN</font></td>
				<td><INPUT TYPE="text" NAME="MSN"
					VALUE="<%=session.getAttribute("MSN")%>" SIZE=51 MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">����</font></td>
				<td><select name="BirthdayYear" size=1>
					<%int YearCounter = new Integer(Birthday.substring(0, 4)).intValue();%>
					<option value="<%=YearCounter%>"><%=YearCounter%></option>
					<%for (YearCounter = 2000; YearCounter >= 1900; YearCounter--) {%>
					<OPTION VALUE="<%=YearCounter%>"><%=YearCounter%></OPTION>
					<%}%>
				</select> �� <select name="BirthdayMonth" size=1>
					<%int MonthCounter =
	new Integer(Birthday.substring(5, Birthday.lastIndexOf('-')))
		.intValue();%>
					<option value="<%=MonthCounter%>"><%=MonthCounter%></option>
					<%for (MonthCounter = 1; MonthCounter <= 12; MonthCounter++) {%>
					<OPTION VALUE="<%=MonthCounter%>"><%=MonthCounter%></OPTION>
					<%}%>
				</select> �� <select name="BirthdayDay" size=1>
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
				</select> ��</td>
			</tr>

			<tr>
				<td width=25%><font color="#164DA8">��ͥסַ</font></td>
				<td><INPUT TYPE="text" NAME="HomeAddress"
					VALUE="<%=session.getAttribute("HomeAddress")%>" SIZE=51
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">��������������</font></td>
				<td><INPUT TYPE="Password" NAME="Password" VALUE="" SIZE=51
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">����������������</font></td>
				<td><INPUT TYPE="Password" NAME="NewPassword" VALUE="" SIZE=51
					MAXLENGTH=50></td>
			</tr>
			<tr>
				<td width=25%><font color="#164DA8">��ȷ������������</font></td>
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
			VALUE="�޸ĸ�����Ϣ"
			style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB"></TD>

	</TR>
</table>

</FORM>

</body>
</html>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
