<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%String TheMessage = "";
//�ж��û��Ƿ��¼
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
//�û��ύ�˱�
if (request.getParameter("Send") != null) {
	//�û�ѡ������Ӳ����¼ѡ��
	if (request
		.getParameter("SendTo")
		.equals("AddFinancialRecord")) {
		if (session
			.getAttribute("IsFinancialManager")
			.equals("True")) {
			response.sendRedirect("addfinancialrecord.jsp");
		}
		else {
			TheMessage = "�����ǲ������Ա����Ȩ�����ѡ��";
		}
	}
	//�û�ѡ���˲��񱨱�ѡ��
	else if (
		request.getParameter("SendTo").equals("FinancialReport")) {
		response.sendRedirect("financialreport.jsp");
	}
	//�û�ѡ�����޸Ĳ����¼ѡ��
	else {
		if (session
			.getAttribute("IsFinancialManager")
			.equals("True")) {
			response.sendRedirect("modifyfinancialrecord.jsp");
		}
		else {
			TheMessage = "�����ǲ������Ա����Ȩ�����ѡ��";
		}
	}
}
else {
	TheMessage = "��ѡ����Ҫ���еĲ�����Ϣ������ģ��";
}
%>

<HTML>
<HEAD>
<TITLE>��˾������Ϣ����ϵͳ</TITLE>
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
		��˾�칫��Ϣ����ϵͳ->������Ϣ������ϵͳ&nbsp[��ǰ�û�- <%=session.getAttribute("Name")%>
		] </font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="../html/home.jsp"><font color="#104DAD">����ϵͳ��ҳ</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		<td align=right><a href="../html/home.jsp"><font color="#104DAD">������һ����ҳ</font></a></td>
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
						<td><font color="#104DAD">������Ϣ������ϵͳ</font> -&nbsp<font
							color="#104DAD">��Ӳ����¼</font></td>
					</tr>
					<tr height=30 align=center>
						<td><input type=radio name=SendTo value=FinancialReport></td>
						<td><font color="#104DAD">������Ϣ������ϵͳ</font> -&nbsp<font
							color="#104DAD">���ɲ��񱨱�</font></td>
					</tr>
					<tr height=30 align=center>
						<td><input type=radio name=SendTo value=ModifyFinancialRecord></td>
						<td><font color="#104DAD">������Ϣ������ϵͳ</font> -&nbsp<font
							color="#104DAD">�޸Ĳ����¼</font></td>
					</tr>
					<tr height=30 align=center>
						<td colspan=3><INPUT TYPE="submit" NAME="Send" VALUE="����ѡ��"
							style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB"></td>
					</tr>
				</table>
				ע�⣺��Ӻ��޸Ĳ����¼��Ҫ�������Ա��ݣ�����׼���룡</td>
			</TR>
		</table>
		</FORM>
</BODY>
</HTML>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
