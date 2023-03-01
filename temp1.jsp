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
   <%
    String my_name=(String)session.getAttribute("fren");
    out.print(my_name);
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe"); 
    Statement stmt=con.createStatement();
    Date date = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
    String strDate = formatter.format(date);
    UUID uuid = UUID.randomUUID();
    String uuidAsString = uuid.toString();
    session.setAttribute("temp_id1", uuidAsString);
    int i =stmt.executeUpdate("update users set profile_id='"+uuidAsString+"' where user_name='"+my_name+"'");  
    response.sendRedirect("post1.html");
    %>
</body>
</html>