<%@ page contentType="text/html;charset=gb2312" import="java.sql.*"%>
<jsp:useBean id="dbconn" scope="page"
	class="cn.edu.buaa.nlsde.bean.DBConnBean" />
<%ResultSet rs = null;
Connection conn = null;
dbconn.setServer("127.0.0.1"); //设置DB的服务器名或者IP
dbconn.setPort("1433"); //设置DB的监听端口
dbconn.setDB("EIMS"); //设置DB的数据库名
dbconn.setUser("sa"); //设置连接DB的用户名
dbconn.setPass("password"); //设置连接DB的密码
conn = dbconn.getConn();
rs = dbconn.executeSQL("select * from PSLogins");
while (rs.next()) {%>
Row:
<%=rs.getString(1)%>
<%}%>
<%out.print("Successful!\n");%>
<%rs.close();
conn.close();
%>