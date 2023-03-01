<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<% Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
String my_id=(String)session.getAttribute("username");
String new_password=request.getParameter("new_password");
Statement stmt=con.createStatement();
String sql="Update users set password ='" +new_password+"' where user_name='"+my_id+"'";
PreparedStatement ps=con.prepareStatement(sql);
int i=ps.executeUpdate();%>