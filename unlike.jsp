<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<% Class.forName("oracle.jdbc.driver.OracleDriver");
String pid=request.getParameter("pid");
String my_name=(String)session.getAttribute("username");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
Statement stmt=con.createStatement();
int i=stmt.executeUpdate("delete from likes where user_name='"+my_name+"' and post_id='"+pid+"'");
response.sendRedirect("yolo.jsp");%>