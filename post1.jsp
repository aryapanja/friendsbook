<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
String text=request.getParameter("my_post");
String my_name=(String)session.getAttribute("username");
String my_realname=(String)session.getAttribute("user_realname");
String my_profileid=(String)session.getAttribute("user_profilepic");
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe"); 
Statement stmt=con.createStatement();
String num ="";
ResultSet rs=stmt.executeQuery("select count(*) from post");
while(rs.next()){
 num = rs.getString("count(*)");
}
num = String.valueOf(Integer.parseInt(num)+1);
Date date = new Date();  
SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
String strDate = formatter.format(date);
int i =stmt.executeUpdate("insert into post(user_name,text,datecolumn,profilepic,name,slnum) values('"+my_name+"','"+text+"','"+strDate+"','"+my_profileid+"','"+my_realname+"','"+num+"')");
con.close();
response.sendRedirect("yolo.jsp");
%>