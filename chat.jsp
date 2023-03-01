<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CHAT</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
      Class.forName("oracle.jdbc.driver.OracleDriver");
      Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
      String sender=(String)session.getAttribute("username");
      String msgrec=(String)session.getAttribute("msg_receiver");
      String msg=request.getParameter("my_msg");
      Statement stmt=con.createStatement();
      Date date = new Date();  
      long timeMilli = date.getTime();
      SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
      SimpleDateFormat formatter1 = new SimpleDateFormat("HH:mm:ss");
      String strDate = formatter.format(date);
      String time = formatter1.format(date);
      String str_month = String.format("%tb %td, %tY", date, date, date);
      int i=stmt.executeUpdate("insert into chat (sender,message,receiver,date_col,time_col,month_name) values('"+sender+"','"+msg+"','"+msgrec+"','"+strDate+"','"+time+"','"+str_month+"')");
      response.sendRedirect("chatbox.jsp");
  }
    catch(Exception e){}
  %>
</body>
</html>