<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%String text=request.getParameter("comment");
String my_name=(String)session.getAttribute("username");
String pid=request.getParameter("postidd");
if(text.trim().equals("")==false){
 Class.forName("oracle.jdbc.driver.OracleDriver");
 Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe"); 
 Statement stmt=con.createStatement();
 Date date = new Date();  
 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
 String strDate = formatter.format(date);
 int i=stmt.executeUpdate("insert into comments values('"+my_name+"','"+pid+"','"+strDate+"','"+text+"')");
 con.close();
}
response.sendRedirect("yolo.jsp");
%>