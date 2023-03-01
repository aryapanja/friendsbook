<%@ page import="java.sql.*"%>
<%
String p_id=request.getParameter("pid");
String my_name=(String)session.getAttribute("username");
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
Statement stmt=con.createStatement();
Statement stmt1=con.createStatement();
int i =stmt.executeUpdate("insert into likes values('"+my_name+"','"+p_id+"')");
%>
