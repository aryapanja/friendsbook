<!DOCTYPE html>
<html lang="en">
<head>
   <title>Settings</title>
   <link rel="stylesheet" href="setting.css">
</head>
<body>
  <%@ page import="java.sql.*" %>
    <% String p_id=request.getParameter("pid");
    String my_name=(String)session.getAttribute("username");
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe"); Statement stmt=con.createStatement();
    String my_ppic="./image/"+(String)session.getAttribute("user_profilepic")+".jpg";%>
    <div class="navbar">
      <img src="logo.png" alt="" width="4%">
      <a href="Login.html">Log out</a>
      <a href="yolo.jsp">Back</a>
      <%if(my_ppic.equals(". /image/-.jpg")){ %>
        <img src="image/pimg.png" alt="hey" width="3%"
          style="float: right; border-radius: 50%; margin-top: 8px; margin-right: 10px;">
        <%}else{%>
          <img src="<%=my_ppic%>" alt="hey" width="3%"
            style="float: right; border-radius: 50%; margin-top: 8px; margin-right: 10px;">
          <%}%>
    </div>
    <div id="main">
        <button id="change_name">Change Name</button>
        <div id="name_div">
          <form action="change_name.jsp">
            <input type="text" name="new_name" placeholder="Enter new name" required>
            <input type="submit" value="submit">
          </form>
        </div>
        <button id="change_username">Change Username</button>
        <div id="username_div">
          <form>
            <input type="text" name="new_username" id="new_username" placeholder="Enter new username" required>
          </form>
          <button id="username" style="float:right; margin-top: -20px; margin-right: 230px;">submit</button>
        </div>
        <button id="change_email">Change Email</button>
        <div id="email_div">
          <form action="change_email.jsp">
            <input type="email" name="new_email" placeholder="Enter new email" required>
            <input type="submit" value="submit">
          </form>
        </div>
        <button id="change_password">Change Password</button>
        <div id="password_div">
          <form>
            <%
            String old = "";
            ResultSet rs = stmt.executeQuery("select password from users where user_name='"+my_name+"'");
            while(rs.next()){
              old = rs.getString("password");
            }%>
            <input type="hidden" value="<%=old%>" id="old">
            <input type="text" name="old_password" id="old_password" placeholder="Enter excisting password"> <br>
            <input type = "text" name="new_password" id="new_password" placeholder="Enter new password"><br>
            <button id="ok">submit</button>
          </form>
        </div>
        <button id="change_ppic">Change Profile Picture</button>
  </div>
</body>
<script src="js/jquery.js"></script>
<script>
 $("document").ready(function(){

   $("#change_name").click(function(){
    $("#name_div").slideToggle();
   });

   $("#change_username").click(function(){
     $("#username_div").slideToggle();
   });

   $("#change_email").click(function () {
     $("#email_div").slideToggle();
   });

   $("#change_password").click(function () {
     $("#password_div").slideToggle();
   });

   $("#change_ppic").click(function(){
    $(location).attr('href', 'temp2.jsp');
   });

   $("#ok").click(function(){
     var old_password = $("#old_password").val();
     var new_password = $("#new_password").val();
     var old = $("#old").val();
     old_password = old_password.trim();
     new_password = new_password.trim();
     if (old_password == "" || new_password == "") {
       alert("Both fields must be filled, cannot be empty!");
     }
     else if (old != old_password) {
       alert("old password is incorrect");
     }
     else if (old_password === new_password) {
       alert("New password is similar to old password");
     }
     else {
       $.ajax({
         url: "change_password.jsp",
         type: 'POST',
         data: { new_password: new_password },
         success: function () {
           $("#old_password").val("");
           $("#new_password").val("");
           alert("password successfully changed");
           $(location).attr('href', 'yolo.jsp');
         }
       });
     }
   });

   $("#username").click(function(){
     var new_username = $("#new_username").val();
     new_username = new_username.trim();
     if(new_username==""){
       alert("Enter a username");
     }
     else{
      $.ajax({
        url:"change_username.jsp",
        type:'POST',
        data : { new_username: new_username},
        success: function(data){
          alert(data);
          $(location).attr('href', 'yolo.jsp');
        }
      });
    }
   });
 });
</script>
</html>