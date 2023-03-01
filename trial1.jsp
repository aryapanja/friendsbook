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

  body {
  margin: 0 auto;
  max-width: 800px;
  padding: 0 20px;
}

.sender {
  border: 2px solid rgb(121, 209, 250);
  background: rgb(93, 204, 255);
  border-radius: 5px;
  padding: 10px;
  margin: 10px 0;
}

.darker {
  border-color: rgb(219, 219, 219);
  background-color: rgb(219, 219, 219);
}

.sender::after {
  content: "";
  clear: both;
  display: table;
}

.sender img {
  float: left;
  max-width: 60px;
  width: 100%;
  margin-right: 20px;
  border-radius: 50%;
}

.sender img.right {
  float: right;
  margin-left: 20px;
  margin-right:0;
}

.time-right {
  float: right;
  color: rgb(0, 85, 182);
}

.time-left {
  float: left;
  color: rgb(121, 119, 119);
}
</style>
</head>

<body>

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
     String img_sender="";
     String img_receiver="";

     ResultSet rs1 = stmt.executeQuery("select profile_id from users where user_name='"+sender+"'");
     while(rs1.next()){
        img_sender = rs1.getString("profile_id")+".jpg";
     }
     String fname="./image/";
     String s=fname+img_sender;

     ResultSet rs2 = stmt.executeQuery("select profile_id from users where user_name='"+r+"'");
     while(rs2.next()){
        img_receiver = rs2.getString("profile_id")+".jpg";
     }
     String fname1="./image/";
     String s1=fname1+img_receiver;

     ResultSet rs=stmt.executeQuery("select * from chat where(sender='"+sender+"' and receiver='"+r+"' ) or (sender='"+r+"' and receiver='"+sender+"') order by date_col,time_col");

     while(rs.next()) { 
      if(rs.getString(1).equals(sender)){ 
      String time=rs.getString("time_col").substring(0, rs.getString("time_col").length() - 3) + " | " + rs.getString("month_name"); %>
       <div class="sender">
        <img src="<%=s%>" style="width:100%;">
        <p><%=rs.getString(2)%></p>
        <span class="time-right"><%=time%></span>
       </div>
     <% } 
     else if(rs.getString(1).equals(r)){ 
      String time=rs.getString("time_col").substring(0,rs.getString("time_col").length() - 3) + " | " + rs.getString("month_name"); %>
      <div class="sender darker">
       <img src="<%=s1%>" class="right" style="width:100%;">
       <p><%=rs.getString(2)%></p>
       <span class="time-left"><%=time%></span>
      </div>
   <% } %><br>
<% }
   con.close(); %>
</body>
<script src="js/jquery.js"></script>
<script>
  $("document").ready(function(){
    if (localStorage.getItem("flagg") == "1"){
      window.scrollTo(0, document.body.scrollHeight);
      localStorage.setItem("flagg", "0");
    }
    else if(localStorage.getItem("flag2") == "1"){
      window.scrollTo(0, document.body.scrollHeight);
      localStorage.setItem("flag2", "0");
    }
  });
</script>
</html>