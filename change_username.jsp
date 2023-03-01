<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<% Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
String new_username = request.getParameter("new_username");
String my_id=(String)session.getAttribute("username");
Statement stmt=con.createStatement();
int flag = 0;
ResultSet rs = stmt.executeQuery("select user_name from users where user_name='"+new_username+"'");
while(rs.next()){
 flag = 1;
}
if(new_username.equals(my_id)){
 out.print("New username should be different than existing username");
}
else if(flag == 1){
 out.print("Username already exists, try a different one");
}
else{
 String s1="Update users set user_name ='"+new_username+"' where user_name='"+my_id+"'";
 String s2="Update friendlist set me ='"+new_username+"' where me='"+my_id+"'";
 String s3="Update friendlist set my_friend ='"+new_username+"' where my_friend='"+my_id+"'";
 String s4="Update request set sender ='"+new_username+"' where sender='"+my_id+"'";
 String s5="Update request set receiver ='"+new_username+"' where receiver='"+my_id+"'";
 String s6="Update chat set sender ='"+new_username+"' where sender='"+my_id+"'";
 String s7="Update chat set receiver ='"+new_username+"' where receiver='"+my_id+"'";
 String s8="Update post set user_name ='"+new_username+"' where user_name='"+my_id+"'";
 String s9="Update comments set user_name ='"+new_username+"' where user_name='"+my_id+"'";
 String s10="Update likes set user_name ='"+new_username+"' where user_name='"+my_id+"'";
 stmt.addBatch(s1);
 stmt.addBatch(s2);
 stmt.addBatch(s3);
 stmt.addBatch(s4);
 stmt.addBatch(s5);
 stmt.addBatch(s6);
 stmt.addBatch(s7);
 stmt.addBatch(s8);
 stmt.addBatch(s9);
 stmt.addBatch(s10);
 stmt.executeBatch();
 session.putValue("username",new_username);
 out.print("Username successfully changed");
}
con.close();
%>