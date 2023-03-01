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
     con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe"); String
     my_id=(String)session.getAttribute("username"); String new_name=request.getParameter("new_name"); Statement
     stmt=con.createStatement(); String sql="Update users set name ='" +new_name+"' where user_name='"+my_id+"'";
 PreparedStatement ps=con.prepareStatement(sql);
 int i=ps.executeUpdate();
 response.sendRedirect(" yolo.jsp");%>
</body>
</html>

