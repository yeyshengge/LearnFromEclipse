<%@ page contentType="text/html; charset=gb2312" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%String TheMessage = "��ѡ���������Ĺ���ģ��";
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}%>
<%Calendar cal = Calendar.getInstance();
SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
String Time = format.format(cal.getTime());
format = new SimpleDateFormat("yyyy-MM-dd");
String Date = format.format(cal.getTime());
String Welcome = "���ã�";
if (Time.compareTo("00:00:00") >= 0
	&& Time.compareTo("12:00:00") < 0) {
	Welcome = "�����!";
}
else if (
	Time.compareTo("12:00:00") >= 0
		&& Time.compareTo("18:00:00") < 0) {
	Welcome = "�����!";
}
else {
	Welcome = "���Ϻ�!";
}%>

<html>
<head>
<title>��ҵ�칫��Ϣ����ϵͳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
		<td height="13"><img src="../image/banner2.jpg" width="800"
			height="12"></td>
	</tr>
</table>
<table width=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>
	<tr>
		<td colspan=3>
		<div align="center"><font color=white> ��˾�칫��Ϣ����ϵͳ->��ҳ&nbsp[��ǰ�û�-<%=session.getAttribute("Name")%>]</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href="../login.jsp"><font color="#104DAD">�˳��칫ϵͳ</font></a></td>
		<td align=center><font color="#104DAD"><%=TheMessage%></FONT></td>
		
    <td align=right><a href="../help.jsp"><font color="#104DAD">ϵͳʹ��˵��</font></a></td>
	</tr>
</table>
<table width="800" border="0" bordercolor="#164DA8" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="13"><img src="../image/banner2.jpg" width="800"
			height="12"></td>
	</tr>
</table>
<br/>
<table width=800 border=0 bgcolor=#164DA8 cellspacing=1 cellpadding=2
	align=center>
	<tr bgcolor=white height=50 background="../image/back.jpg">
		
    <td  width="45%" align=center bgcolor=#ADBEDE><img
			src="../image/homepagepicture1.jpg" ></td>
		<td>
		<table width=100% border=0>
			<tr>
				<td>
				<p align=center><img src="../image/lable.jpg"><br>
				</p>
				</td>
			</tr>
			<tr height=20>
				<td>
				<p align=center><font color="#104DAD"> <%=Welcome%><%=session.getAttribute("Name")%>,��ӭ������EIMS!������<%=Date%>.
				</font></p>
				</td>
			</tr>

			<tr bgcolor=white height=50>
				
          <td align=center><a href="../employee/employeeinformation.jsp"><font
					color="#104DAD">��˾Ա����Ϣ������ϵͳ</font></a></td>
			</tr>
			<tr bgcolor=white height=50>
				
          <td align=center><a href="../finance/finance.jsp"><font
					color="#104DAD">��˾������Ϣ������ϵͳ</font></a></td>
			</tr>
			<tr bgcolor=white height=50>
				
          <td align=center><a href="../messageboard/communication.jsp"> <font
					color="#104DAD">��˾�ڲ���Ϣ������ϵͳ</FONT></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</body>
</html>
