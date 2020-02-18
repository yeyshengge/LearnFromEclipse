<%@ page contentType="text/html; charset=gb2312" language="java"  %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="cn.edu.buaa.nlsde.db.*"%>

<%request.setCharacterEncoding("GB2312");
String TheMessage = "";
Calendar cal = Calendar.getInstance();
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String Time = format.format(cal.getTime());
format = new SimpleDateFormat("yyyy-MM-dd");
String Date = format.format(cal.getTime());
//判断用户是否登录和是否具有要修改的通知的ID号
if (session.getAttribute("ID") == null) {
	response.sendRedirect("../login.jsp");
}
if (session.getAttribute("MessageID") == null) {
	response.sendRedirect("messageboard.jsp");
}
//连接系统数据库
//Connection conn = (new DBConnect()).getODBCConn("EIMS");
Connection conn = (new DBConnect()).getConnPoolConn("eims");
Statement stmt = conn.createStatement();
boolean Warning = false;
//用户单击了修改此条通知的按钮
if (request.getParameter("ModifyMessage") != null) {
	//校验修改后的通知的内容
	if (request.getParameter("MessageContent").trim().equals("")) {
		TheMessage = "通知内容不能为空，请重填这条通知";
		Warning = true;
	}
	else {
		stmt.executeUpdate(
			" update Messageboard set MessageContent='"
				+ request.getParameter("MessageContent")
				+ "', MessageSendDate='"
				+ Date
				+ "', MessageSendTime='"
				+ Time
				+ "', MessageValidTime="
				+ request.getParameter("MessageValidTime")
				+ " Where MessageID="
				+ session.getAttribute("MessageID"));
		TheMessage = "通知修改成功";
		Warning = false;
	}
}
else {
	TheMessage = "请在下面修改这条通知";
	Warning = false;
}
ResultSet RSThisMessage =
	stmt.executeQuery(
		"select * from MessageBoard where MessageID="
			+ ((Integer)session.getAttribute("MessageID")).intValue());
Hashtable HTThisMessage = new Hashtable();
while (RSThisMessage.next()) {
	HTThisMessage.put(
		"MessageID",
		new Integer(RSThisMessage.getInt(1)));
	HTThisMessage.put("MessageContent", RSThisMessage.getString(2));
	HTThisMessage.put("MessageType", RSThisMessage.getString(3));
	HTThisMessage.put("MessageSender", RSThisMessage.getString(4));
	HTThisMessage.put(
		"MessageSendDate",
		RSThisMessage.getString(5).substring(0, 10));
	HTThisMessage.put(
		"MessageValidTime",
		new Integer(RSThisMessage.getInt(7)));
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
		<div align="center"><font color=white>公司办公信息管理系统->内部信息交流系统->内部通知公共牌->修改通知[当前用户-<%=session.getAttribute("Name")%>]
		</font></div>
		</td>
	</tr>
	<tr bgcolor=white>
		<td><a href=".././html/home.jsp"><font color="#104DAD">返回系统主页</font></a></td>
		<td align=center><%if (Warning == true) {%> <font color=red><%=TheMessage%></FONT>
		<%}
else {%> <font color="#104DAD"><%=TheMessage%></FONT> <%}%></td>
		<td align=right><a href="messageboard.jsp"><font color="#104DAD">返回上一级网页</font></a></td>
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

		<FORM ACTION="modifymessage.jsp" METHOD=POST>
		<table width=100% border=1>
			<tr>
				<td>此条通知ID</td>
				<td><%=((Integer)HTThisMessage.get("MessageID")).intValue()%></td>
			</tr>
			<tr>
				<td>此条通知接受者</td>
				<td><%=HTThisMessage.get("MessageType")%></td>
			</tr>
			<tr>
				<td>此条通知发送者</td>
				<td><%=HTThisMessage.get("MessageSender")%></td>
			</tr>
			<tr>
				<td>此条通知发送日期</td>
				<td><%=HTThisMessage.get("MessageSendDate")%></td>
			</tr>
			<tr>
				<td>此条通知有效天数</td>
				<td><select name=MessageValidTime>
					<option
						value=<%=((Integer)HTThisMessage.get("MessageValidTime")).intValue()%>><%=((Integer)HTThisMessage.get("MessageValidTime")).intValue()%>天</option>
					<%for (int ccounter = 1; ccounter <= 31; ccounter++) {%>
					<OPTION VALUE=<%=ccounter%>><%=ccounter%>天</OPTION>
					<%}%>
				</select></td>
			</tr>
			<tr>
				<td>请修改此条通知的内容</td>
				<td><TEXTAREA NAME="MessageContent" ROWS=6 COLS=40><%=HTThisMessage.get("MessageContent")%></TEXTAREA>
				</td>
			</tr>
			<tr>
				<td colspan=2 align=center><input type=submit name=ModifyMessage
					value="修改此条通知"
					style="border: 1px solid #3466BB; background-color: #B6CAEB; color: #3466BB">
				</td>
			</tr>
		</table>
		</form>

		</td>
	</tr>
</table>


</body>
</html>
<%DBConnectionManager.getInstance().freeConnection("eims", conn);%>
