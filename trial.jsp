<!DOCTYPE html>
<html lang="en">

<head>
   <meta charset="UTF-8">
   <meta http-equiv="refresh" content="3">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Document</title>
   <style>
      ::-webkit-scrollbar {
         display: none;
      }
      .sender{
         width:250px;
         overflow-wrap: break-word;
         border-radius: 10px;
         border: black 1px solid;
      }
      .receiver{
         width:250px;
         overflow-wrap: break-word;
         border-radius: 10px;
         margin-left: 180px;
         border: black 1px solid;
      }
      
   </style>
</head>

<body>
   <%@ page import="java.sql.*" %>
   <%@ page import="java.util.*" %>
   <%@ page contentType="text/html" pageEncoding="UTF-8" %>
   <% Class.forName("oracle.jdbc.driver.OracleDriver");
   Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
   String sender=(String)session.getAttribute("username");
   Statement stmt=con.createStatement();
   String r=(String)session.getAttribute("msg_receiver");
   ResultSet rs=stmt.executeQuery("select * from chat where (sender='"+sender+"' and receiver='"+r+"' ) or (sender='"+r+"' and receiver='"+sender+"' ) order by date_col,time_col");
   while(rs.next()) {
      if(rs.getString(1).equals(sender)){

         String time = rs.getString("time_col").substring(0, rs.getString("time_col").length() - 3)  + " | " + rs.getString("date_col");

         %> <div class="sender"> <p><%=rs.getString(2)%> <br> <%=time%></p></div>
         <%
      }
      else if(rs.getString(1).equals(r)){

         String time = rs.getString("time_col").substring(0, rs.getString("time_col").length() - 3) + " | " + rs.getString("date_col");

         %> <div class="receiver"> <p><%=rs.getString(1)%> : <%=rs.getString(2)%> <br> <%=time%></p></div>
         <%
      }
      %><br>
<% } %>
</body>
</html>