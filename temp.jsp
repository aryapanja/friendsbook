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
    String my_name=(String)session.getAttribute("username");
    String my_profileid=(String)session.getAttribute("user_profilepic");
    String my_realname=(String)session.getAttribute("user_realname");
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe"); 
    Statement stmt=con.createStatement();
    String num ="";
    ResultSet rs=stmt.executeQuery("select max(slnum) from post");
    while(rs.next()){
        num = rs.getString("max(slnum)");
    }
    num = String.valueOf(Integer.parseInt(num)+1);
    Date date = new Date();  
    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
    String strDate = formatter.format(date);
    UUID uuid = UUID.randomUUID();
    String uuidAsString = uuid.toString();
    session.setAttribute("temp_id", uuidAsString);
    int i =stmt.executeUpdate("insert into post(user_name,datecolumn,post_id,profilepic,name,slnum) values('"+my_name+"','"+strDate+"','"+uuidAsString+"','"+my_profileid+"','"+my_realname+"','"+num+"')");
    response.sendRedirect("post.html");
    %>
</body>
</html>