<html>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
    Statement stmt=con.createStatement();
    String sender_profile_id="";
    String my_name=(String)session.getAttribute("username");
    String receiver= request.getParameter("req_uname");
    String receiver_name= request.getParameter("req_name");
    ResultSet rs = stmt.executeQuery("select profile_id from users where user_name='"+my_name+"'");
    while(rs.next()){
        sender_profile_id = rs.getString("profile_id");
    }
    out.print(sender_profile_id);
    int i= stmt.executeUpdate("insert into request values( '"+my_name+"','"+receiver+"','"+receiver_name+"','"+sender_profile_id+"')");
    response.sendRedirect("yolo.jsp");
    con.close();
%>
</body>
</html>