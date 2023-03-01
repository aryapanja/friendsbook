
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%Class.forName("oracle.jdbc.driver.OracleDriver");
String usernaam=(String)session.getAttribute("fren");
String profile_id="";
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe"); 
Statement stmt=con.createStatement();
out.print(usernaam);
ResultSet rs = stmt.executeQuery("select profile_id from users where user_name='"+usernaam+"'");
while(rs.next()){
  profile_id=rs.getString("profile_id");
}
int i = stmt.executeUpdate("UPDATE users SET profile_id='"+"-"+"' where user_name='"+usernaam+"'");
response.sendRedirect("Login.html");
%>