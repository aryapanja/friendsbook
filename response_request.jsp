<!DOCTYPE html>
<html lang="en">
<head>
 <title>Document</title>
</head>

<body>
   <%@ page import="java.sql.*" %>
   <%@ page import="java.util.*" %>
   <%@ page contentType="text/html" pageEncoding="UTF-8" %>
   <% Class.forName("oracle.jdbc.driver.OracleDriver"); Connection
   con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe"); 
   Statement stmt=con.createStatement();
   String my_name=(String)session.getAttribute("username");
   String my_realname=(String)session.getAttribute("user_realname");
   String sender = request.getParameter("send_name");
   String check1 = request.getParameter("accept");
   String check2 = request.getParameter("delete");
   out.print(check2);

   String img_me="";
   String img_myfren="";
   String sender_realname="";

   ResultSet rs = stmt.executeQuery("select name from users where user_name='"+sender+"'");
   while(rs.next()){
      sender_realname = rs.getString("name");
   }

   ResultSet rs1 = stmt.executeQuery("select profile_id from users where user_name='"+my_name+"'");
   while(rs1.next()){
      img_me = rs1.getString("profile_id");
   }

   ResultSet rs2 = stmt.executeQuery("select profile_id from users where user_name='"+sender+"'");
   while(rs2.next()){
      img_myfren = rs2.getString("profile_id");
   }

   if(check1 != null && check1.equals("Accept")){
    int i = stmt.executeUpdate("insert into friendlist values('"+my_name+"','"+sender+"','"+img_myfren+"','"+sender_realname+"')");
    int j = stmt.executeUpdate("insert into friendlist values('"+sender+"','"+my_name+"','"+img_me+"','"+my_realname+"')");
    int k = stmt.executeUpdate("delete from request where sender='"+sender+"' and receiver='"+my_name+"'");
    response.sendRedirect("yolo.jsp");
   }
   else{
    int k = stmt.executeUpdate("delete from request where sender='"+sender+"' and receiver='"+my_name+"'");
    response.sendRedirect("yolo.jsp");
   }
   %>
</body>
</html>