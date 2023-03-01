<%String p_id=request.getParameter("pid");
String my_name=(String)session.getAttribute("username");%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<% Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
Statement stmt=con.createStatement();
int i =stmt.executeUpdate("insert into likes values('"+my_name+"','"+p_id+"')");
ResultSet rs=stmt.executeQuery("select count(*) from likes where user_name='"+my_name+"' and post_id='"+p_id+"'");
while(rs.next()){
 out.print(<%=rs.getInt("count(*)")%>);
}
%>