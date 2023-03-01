<html>
 <head>
   <script>
    
     function validate(){
       alert("Username exist");
       
     }
   </script>
 </head>

<body>
 <%@ page import="java.sql.*" %>
  <%@ page import="java.util.*" %>
   <%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <% 
     String username=request.getParameter("unum");
     String name = request.getParameter("name");
     String email = request.getParameter("email");
     String password=request.getParameter("psw");
     Class.forName("oracle.jdbc.driver.OracleDriver");
     Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe"); Statement stmt=con.createStatement();
     ResultSet rs = stmt.executeQuery("select * from users where user_name='"+username+"'");
      if(rs.next()){
        %><script>validate();</script><%
          response.sendRedirect("Login.html");
    
      }
				else{
					int i=stmt.executeUpdate("insert into users(user_name,name,password,email) values ('"+username+"','"+name+"','"+password+"','"+email+"')");
          session.putValue("fren",username);
					response.sendRedirect("temp1.jsp");
			 }
			con.close();
   %> 
  </body>
</html>