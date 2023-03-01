<!DOCTYPE html>
<html lang="en">

<head>
 <meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title>Document</title>
</head>

<body>
 <%@ page import="java.sql.*" %>
 <%@ page import="java.util.Date" %>
 <%@ page import="java.text.SimpleDateFormat" %>
 <%@ page contentType="text/html" pageEncoding="UTF-8" %>
 <%@ page import="java.util.UUID" %>
 <% String my_name=(String)session.getAttribute("username");
 out.print(my_name);
 Class.forName("oracle.jdbc.driver.OracleDriver");
 Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe"); Statement stmt=con.createStatement();
 UUID uuid=UUID.randomUUID();
 String uuidAsString=uuid.toString();
 session.setAttribute("temp_id2", uuidAsString);
 int i=stmt.executeUpdate("update users set profile_id='"+uuidAsString+"' where user_name='"+my_name+"'"); 
 int j=stmt.executeUpdate("update post set profilepic='"+uuidAsString+"' where user_name='"+my_name+"'"); 
 int k=stmt.executeUpdate("update friendlist set profilepic='"+uuidAsString+"' where my_friend='"+my_name+"'"); 
 int l=stmt.executeUpdate("update request set sender_profile_id ='"+uuidAsString+"' where sender='"+my_name+"'");
 response.sendRedirect("post2.html"); %>
</body>

</html>