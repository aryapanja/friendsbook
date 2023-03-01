<html>

<head>

</head>

<body>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
    String my_name=(String)session.getAttribute("username");
    String my_realname=(String)session.getAttribute("user_realname");
    Statement stmt=con.createStatement();
           		%><div>
                   <center><h1 style="background-color:rgb(142, 194, 144);">Welcome <%=my_realname%> :)</h1></center>
                <center>
                <form action="temp.jsp" method="post">
                    <textarea name="my_post"  , column="30" , row="20" , placeholder="What's in your mind"></textarea><br>	
                    <input type="submit" value="Post">
                </form>
                </center>
                </div>
             <%
                ResultSet rs1=stmt.executeQuery("select user_name from users where user_name !='"+my_name+"' and user_name not in(select sender from request where receiver='"+my_name+"') and user_name not in(select receiver from request where sender='"+my_name+"') and user_name not in(select my_friend from friendlist where me='"+my_name+"')");
                %><div><h1>FRIEND SUGGESTION</h1><%
                while(rs1.next())
                {
                    %>
                        <table border="2px">
                            <tr>
                                <td><h1><%=rs1.getString("user_name") %></h1></td>
                            </tr>
                            <tr>
                                <td>
                                    <form action="sent_request.jsp" method="post">
                                    <input type='hidden' name="req_name" value="<%=rs1.getString("user_name") %>">
                                    <input type="Submit" value="Request"></form>
                                </td>
                            </tr>
                        </table>
                    <%
    	        }
                %></div><%
                ResultSet rs=stmt.executeQuery("select sender from request where receiver='"+my_name+"'");
                %><div><h1>FRIEND REQUESTS</h1><%
                while(rs.next())
                {
                    %>
                        <h1><%=rs.getString("sender") %></h1>
                        <form action="response_request.jsp" name="response" method="post">
                        <input type='hidden' name="send_name" value="<%=rs.getString("sender") %>">
                        <input type="Submit" name="accept" value="Accept" on>
                        <input type="Submit" name="delete" value="Delete"></form>
                    <%
                }
                %></div><%
                ResultSet rs2=stmt.executeQuery("select my_friend from friendlist where me='"+my_name+"'");
                %><div><h1>FRIENDS</h1><%
                while(rs2.next()){
                    %>
                    <table>
                    <tr>
                    <td> <h1><%=rs2.getString("my_friend") %></h1></td>
                    </tr>
                    <tr>
                        <td>
                            <form action="setvalue.jsp" method="post">
                            <input type='hidden' name="friend" value="<%=rs2.getString("my_friend") %>">
                            <input type="Submit" value="chat"></form>
                        </td>
                    </tr>
                    </table>
                    <%
                }
                %></div><%
                ResultSet rs3=stmt.executeQuery("select * from post where user_name='"+my_name+"' or user_name in(select my_friend from friendlist where me='"+my_name+"') order by datecolumn desc");
                %> <div><h1>POSTS</h1><%
                while(rs3.next()){
                    %>
                    <h1><%=rs3.getString("user_name")%></h1>
                    <p><%=rs3.getString("text")%></p> 
                    <% String id=rs3.getString("post_id")+".jpg";
                     String fname="./image/";
                     String s=fname+id;
                     %>
                    <img src="<%=s%>" height="300" width="150">
                    <%
                }
                %></div><%
        con.close();
%>
</body>
</html>