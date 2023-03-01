<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=ISO-8859-1" %>
<% String empid=request.getParameter("id");
  Class.forName("oracle.jdbc.driver.OracleDriver");
  Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
  Statement stmt=con.createStatement();
  ResultSet rs=stmt.executeQuery("select user_name from users");
  while(rs.next()){
    out.print(rs.getString("user_name")+"&");
  }
  con.close();
%>
