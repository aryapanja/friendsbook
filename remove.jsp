<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<% Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
Statement stmt=con.createStatement();
String my_name=(String)session.getAttribute("username");
String friend=request.getParameter("friend");
int i=stmt.executeUpdate("delete from chat where sender='"+friend+"' and receiver='"+my_name+"'");
int j=stmt.executeUpdate("delete from chat where sender='"+my_name+"' and receiver='"+friend+"'");
int k =stmt.executeUpdate("delete from friendlist where me='"+my_name+"' and my_friend='"+friend+"'");
int l =stmt.executeUpdate("delete from friendlist where me='"+friend+"' and my_friend='"+my_name+"'");
response.sendRedirect("yolo.jsp");%>