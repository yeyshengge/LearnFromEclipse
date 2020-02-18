<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
Vector VTDepartments = new Vector();
Vector VTRoles = new Vector();
if (session.getAttribute("VTDepartments") != null) {
	VTDepartments = (Vector)session.getAttribute("VTDepartments");
}
if (session.getAttribute("VTRoles") != null) {
	VTRoles = (Vector)session.getAttribute("VTRoles");
}
String temp = "";
boolean label = false;
//�ж��û��Ƿ��¼
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
//����ϵͳ���ݿ�
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
ResultSet RSEnquiryResult = null;
//�ж��û��Ƿ��ύ�˱�
if (request.getParameter("Send") != null) {
	//����û�ϣ����ѯȫ��Ա����Ϣ
	if (request
		.getParameter("SendTo")
		.equals("AllEmployeeInformation")) {
		RSEnquiryResult =
			stmt.executeQuery(
				"select * from PSLogins order by "
					+ request.getParameter("AllOrder"));
		TheMessage =
			"ȫ��Ա����Ϣ��" + request.getParameter("AllOrder") + "��������";
		label = true;
	}
	//����û�ϣ����ѯĳ������Ա����Ϣ
	else if (
		request.getParameter("SendTo").equals(
			"DepartmentEmployeeInformation")) {
		RSEnquiryResult =
			stmt.executeQuery(
				"select * from PSLogins where Department = '"
					+ request.getParameter("DepartmentName")
					+ "' order by Position");
		TheMessage =
			request.getParameter("DepartmentName") + "ȫ��Ա����Ϣ����";
		label = true;
	}
	//����û�ϣ�������޸ĸ�����Ϣҳ��
	else if (
		request.getParameter("SendTo").equals(
			"ModifyPersonalInformation")) {
		response.sendRedirect("modifypersonalinformation.jsp");
	}
	//����û�ϣ������ϵͳ����Աҳ��
	else if (
		request.getParameter("SendTo").equals("SystemManager")) {
		if (session.getAttribute("IsSystemManager").equals("True")) {
			session.setAttribute(
				"SystemOrder",
				request.getParameter("SystemOrder"));
			response.sendRedirect("systemmanager.jsp");
		}
		else {
			TheMessage = " �Բ���������ϵͳ����Ա��û�д���Ȩ��";
			label = false;
		}
	}
	//����û�ϣ����ѯĳ��Ա����Ϣ
	else if (
		request.getParameter("SendTo").equals(
			"OneEmployeeInformation")) {
		label = true;
		if (request.getParameter("CheckName").equals("FromList")) {
			RSEnquiryResult =
				stmt.executeQuery(
					"select * from PSLogins where Name = '"
						+ request.getParameter("RoleName")
						+ "'");
			TheMessage =
				"��ѯԱ��" + request.getParameter("RoleName") + "��Ϣ�������";
		}
		else {
			RSEnquiryResult =
				stmt.executeQuery(
					"select * from PSLogins where Name = '"
						+ request.getParameter("TypeName")
						+ "'");
			TheMessage =
				"��ѯԱ��" + request.getParameter("TypeName") + "��Ϣ�������";
		}
	}
	//����û�ϣ����ѯ����������Ϣ
	else {
		RSEnquiryResult =
			stmt.executeQuery(
				"select * from PSLogins where Position='����'");
		TheMessage = "������������Ϣ����";
		label = true;
	}
}
//����û��ǵ�һ�ν���ҳ��
else {
	TheMessage = "��������ѡ��Ա����Ϣ����ѡ��";
	if (session.getAttribute("VTDepartments") != null) {
		VTDepartments = (Vector)session.getAttribute("VTDepartments");
	}
	else {
		ResultSet RSDepartments =
			stmt.executeQuery(
				"select DepartmentName from Departments");
		while (RSDepartments.next()) {
			VTDepartments.add(
				RSDepartments.getString("DepartmentName"));
		}
		session.setAttribute("VTDepartments", VTDepartments);
	}

	if (session.getAttribute("VTRoles") != null) {
		VTRoles = (Vector)session.getAttribute("VTRoles");
	}
	else {
		ResultSet RSRoles =
			stmt.executeQuery("select Name from PSLogins");
		while (RSRoles.next()) {
			VTRoles.add(RSRoles.getString("Name"));
		}
		session.setAttribute("VTRoles", VTRoles);
	}
}
%>

<html>
<head>
<title>Ա����Ϣ������ϵͳ</title>
</head>
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
		��˾�칫��Ϣ����ϵͳ->Ա����Ϣ������ϵͳ&nbsp[��ǰ�û�-<%=session.getAttribute("Name")%>] </font></div>
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
<form action="employeeinformation.jsp#List" method=post>
<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="3" cellspacing="0">
	<tr>
		<td><br>



		<table cellpadding=1 cellspacing=2 border=1 bordercolor="#164DA8"
			width=800 align=center>
			<tr valign="middle" align="center">
				<td width=35% bgcolor=#B5C7EF><img src="../image/employee1.jpg"></td>
				<td>

				<table cellpadding=1 cellspacing=1 border=1 align=center width=100%>
					<tr>
						<td width=35��><input type="radio" checked name="SendTo"
							value="AllEmployeeInformation"> <font color="#164DA8">��ѯ����Ա����Ϣ</font></td>
						<td><input type="radio" checked name="AllOrder" value="Name">����������
						<input type="radio" name="AllOrder" value="Department">���������� <input
							type="radio" name="AllOrder" value="Birthday">����������</td>
					</tr>
					<tr>
						<td width=30��><input type="radio" name="SendTo"
							value="DepartmentEmployeeInformation"> <font color="#164DA8">��ѯĳ������Ա����Ϣ</font></td>
						<td><select name="DepartmentName">
							<%for (int i = 0; i < VTDepartments.size(); i++) {
	temp = (String)VTDepartments.get(i);%>
							<option value="<%=temp%>"><%=temp%></option>
							<%}%>
						</select></td>
					</tr>

					<tr>
						<td><input type="radio" name="SendTo"
							value="OneEmployeeInformation"><font color="#164DA8">��ѯĳ��Ա����Ϣ</font>
						</td>
						<td>

						<table width=100% border=1>
							<tr>
								<td><input type="radio" Checked name="CheckName"
									value="FromList"><font color="#164DA8">���б���ѡ��</font></td>
								<td><select name="RoleName">
									<%for (int i = 0; i < VTRoles.size(); i++) {
	temp = (String)VTRoles.get(i);%>
									<option value="<%=temp%>"><%=temp%></option>
									<%}%>
								</select></td>
							</tr>
							<tr>
								<td><input type="radio" name="CheckName" value="Type"><font
									color="#164DA8">����������ֲ�ѯ</font></td>
								<td><input type="text" Checked name="TypeName" value=""></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width=30%><input type="radio" name="SendTo"
							value="DepartmentManager"> <font color="#164DA8">��ѯ����������Ϣ</font></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td width=30%><input type="radio" name="SendTo"
							value="ModifyPersonalInformation"> <font color="#164DA8">�޸Ĺ����ҵ���Ϣ</font></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td width=30%><input type="radio" name="SendTo"
							value="SystemManager"> <font color="#164DA8">ϵͳ����Աѡ��</font></td>
						<td><input type="radio" name=SystemOrder value="Name" checked>�������������
						<input type="radio" name=SystemOrder value="Department">�Բ����������<br>
						<input type="radio" name=SystemOrder value="Birthday">������������� <input
							type="radio" name=SystemOrder value="Position">��ְλ�������</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>

		<table cellpadding=0 cellspacing=0 BORDER=1 width=800 align=center>
			<tr VALIGN="top" ALIGN="center">
				<td width=100% align=center><input type="submit" name="Send"
					value="����ѡ��"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				</td>
			</tr>
		</table>

		<br>
		<A name=List></A> <%if (request.getParameter("Send") != null) {
	out.println(
		"<table width=100% border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2 align=center>");
	out.println(
		"<tr><td><font color=white><P ALIGN=CENTER>" + TheMessage);
	out.println("</font></td></tr>");
	//����������ѯ���
	if (label == false) {
		out.println("</table>");
	}
	//���Ҫ�����ѯ���
	else {
		out.println("<tr bgcolor=white ><td  align=center>");
		out.println(
			"<table width=100% bgcolor=#164DA8 border=0  cellspacing=1 cellpadding=2 align=center>");
		out.println("<tr><td><font color=white>��¼��</font></td>");
		out.println("<td><font color=white>����</font></td>");
		out.println("<td><font color=white>�����ʼ���ַ</font></td>");
		out.println("<td><font color=white>����</font></td>");
		out.println("<td><font color=white>�ڲ��ֻ�</font></td>");
		out.println("<td><font color=white>��ͥ�绰</font></td>");
		out.println("<td><font color=white>�ƶ��绰</font></td>");
		out.println("<td><font color=white>MSN</font></td>");
		out.println("<td><font color=white>����</font></td></tr>");
		while (RSEnquiryResult.next()) {
			out.println("<tr bgcolor=white>");
			out.println(
				"<td>" + RSEnquiryResult.getString(2) + "</td>");
			out.println(
				"<td>" + RSEnquiryResult.getString(3) + "</td>");
			temp = RSEnquiryResult.getString(5);
			out.println("<td><a href=mailto:" + temp + ">");
			out.println(
				"<font face=arial>" + temp + "</font></a></td>");
			out.println(
				"<td>" + RSEnquiryResult.getString(6) + "</td>");
			out.println(
				"<td>" + RSEnquiryResult.getString(8) + "</td>");
			out.println(
				"<td>" + RSEnquiryResult.getString(9) + "</td>");
			out.println(
				"<td>" + RSEnquiryResult.getString(10) + "</td>");
			out.println(
				"<td>" + RSEnquiryResult.getString(11) + "</td>");
			out.println(
				"<td>"
					+ RSEnquiryResult.getString(14).substring(0, 10)
					+ "</td></tr>");
		}
		out.println("</table></td></tr></table>");
	}
}%></td>
	</tr>
</table>
</form>
</body>
</html>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
