<%@ page contentType="text/html;charset=gb2312" import="java.sql.*"%>
<jsp:useBean id="dbconn" scope="page"
	class="cn.edu.buaa.nlsde.bean.DBConnBean" />
<%ResultSet rs = null;
Connection conn = null;
dbconn.setServer("127.0.0.1"); //����DB�ķ�����������IP
dbconn.setPort("1433"); //����DB�ļ����˿�
dbconn.setDB("EIMS"); //����DB�����ݿ���
dbconn.setUser("sa"); //��������DB���û���
dbconn.setPass("password"); //��������DB������
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