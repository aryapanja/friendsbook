<html>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username=request.getParameter("uname");
    String password=request.getParameter("pass");
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
    Statement stmt=con.createStatement();
    ResultSet rs=stmt.executeQuery("select * from users where user_name='"+username+"'");
    int flag=0;
    if(username.equals("") || password.equals(""))
    {
        flag =1;
        %><center><h1 style="background-color:blue;">All fields are required!!</h1></center>
        <a href="Login.html">try again</a><%
    }
	if(rs.next() && flag!=1)
        {
         if(rs.getString(3).equals(password))
        	{
                session.putValue("username",username);
                session.putValue("user_realname",rs.getString("name"));
                session.putValue("user_profilepic",rs.getString("profile_id"));
                response.sendRedirect("yolo.jsp");
        	}
            else
            {
                %><center><h1 style="background-color:blue;">Login failed!!</h1></center>
                <a href="Login.html">try again</a><%
            }
    	}
    

        con.close();
%>
</body>
</html>