<%@ page contentType="text/html;charset=gb2312"  language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<%int i = 0;  
  Context initCtx = new InitialContext();
  if (initCtx == null){
  	throw new Exception("���ܻ�ȡContext!");
  }
  DataSource ds = (DataSource) initCtx.lookup("java:comp/env/eims");
  Connection conn = ds.getConnection();
  Statement stmt = conn.createStatement();
  PreparedStatement ps=conn.prepareStatement("select * from PSLogins");
  ResultSet rs=ps.executeQuery();
  while(rs.next()){
      out.println(rs.getString("Name")+"<BR>");
      i++;
  }
//rs.close();
//stmt.close();
//conn.close();
out.println("���ӳز��Գɹ���"+i);
%>
