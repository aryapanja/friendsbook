<!DOCTYPE html>
<html lang="en">

<head>
 <link rel="stylesheet" href="profilee.css">
 <link rel="stylesheet" href="jqueryui/jquery-ui.css">
 <link rel="stylesheet" href="jqueryui/jquery-ui.structure.css">
 <link rel="stylesheet" href="jqueryui/jquery-ui.theme.css">

 </script>
</head>

<body>
 <%@ page import="java.sql.*" %>
 <%@ page import="java.util.*" %>
 <%@ page contentType="text/html" pageEncoding="UTF-8" %>
 <% Class.forName("oracle.jdbc.driver.OracleDriver");
 Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
 String my_name=(String)session.getAttribute("username");
 String my_realname=(String)session.getAttribute("user_realname");
 String friend=request.getParameter("usernames");
 String my_ppic="./image/"+(String)session.getAttribute("user_profilepic")+".jpg";
 Statement stmt=con.createStatement();
 Statement stmt1=con.createStatement();
 String friend_name="";
 ResultSet rs0=stmt.executeQuery("select name from users where user_name='"+friend+"'");
 while(rs0.next()){
  friend_name=rs0.getString("name");
 }
 %>
 <div class="navbar">
  <img src="logo.png" alt="" width="4%">
  <a href="settings.jsp">Settings</a>
  <a href="Login.html">Log out</a>
  <a href="yolo.jsp">Home</a>
  <%if(my_ppic.equals("./image/-.jpg")){ %>
  <img src="image/pimg.png" alt="hey" width="3%" style="float: right; border-radius: 50%; margin-top: 8px; margin-right: 10px;">
   <%}else{%>
     <img src="<%=my_ppic%>" alt="hey" width="3%" style="float: right; border-radius: 50%; margin-top: 8px; margin-right: 10px;">
   <%}%>
   <form method="POST" action="profile.jsp">
    <input type="text" name="usernames" id="usernames" onclick="loadNames()" placeholder="Search Friendsbook" required>
    <input type="image" src="search.png" alt="Submit">
   </form>
  </div>

  <div id="main">
    <div id="profile_details">
        <%ResultSet rs=stmt.executeQuery("select * from users where user_name='"+friend+"'");
        while(rs.next()){
          String friend_profile ="./image/"+rs.getString("profile_id")+".jpg";
          %>
          <%if(friend_profile.equals("./image/-.jpg")){ %>
            <img src="image/pimg.png" alt="hi" width="90%" class="ugh">
            <%}else{%>
              <img src="<%=friend_profile%>" alt="hi" width="90%" class="ugh">
          <%}%>
          <br>
          <br>
          <br>
          <p class="det">Username - <%=rs.getString("user_name")%></p>
          <br>
          <p class="det">Name - <%=rs.getString("name")%></p>
          <br>
          <p class="det">Email - <%=rs.getString("email")%></p><%
          }%>
    </div>

    <div id="friendlist" title="friends">
      <%ResultSet rs1 = stmt.executeQuery("select * from friendlist where me='"+friend+"'");
      while(rs1.next()){%>
        <div class="friendlist-container" title="friends">
            <%String friend_profil ="./image/"+rs1.getString("profilepic")+".jpg";
            if(friend_profil.equals("./image/-.jpg")){ %>
            <img src="image/pimg.png" alt="hey" width="30%" class="cont-img">
            <figcaption style="font-size: 18px;"><%=rs1.getString("fullname")%></figcaption>
            <%}else{%>
              <img src="<%=friend_profil%>" alt="hi" width="30%" class="cont-img">
              <figcaption style="font-size: 18px;"><%=rs1.getString("fullname")%></figcaption>
          <%}%>
        </div><%
      }
      %>
    </div>

    <div id="posts">
        <%int flag = 0,flag1=0,flag2=0;
        ResultSet rs2=stmt.executeQuery("select * from friendlist where me='"+my_name+"' and my_friend='"+friend+"'");
        while(rs2.next()){
          flag = 1;
          break;
        }
        ResultSet rs4=stmt.executeQuery("select * from request where sender='"+my_name+"' and receiver='"+friend+"'");
        while(rs4.next()){
          flag1 = 1;
          break;
        }
        ResultSet rs5=stmt.executeQuery("select * from request where sender='"+friend+"' and receiver='"+my_name+"'");
        while(rs5.next()){
          flag2 = 1;
          break;
        }
        if(flag1==1){%>
          <div id="duh" style="background-color: rgb(44, 212, 44);">
            <p style="font-size: 35px; margin-top: 37px; margin-left: 25px; color: rgb(0, 0, 0);">Request not yet accepted</p>
          </div><%
        }
        else if(flag2==1){%>
          <div id="duh" style="background-color: rgb(44, 212, 44);">
            <p style="font-size: 30px; color: black; margin-top: 15px;">Accept the friend request<br>To know what he/she shares!!!</p>
          </div><%
        }
        else if((flag == 0) && (friend.equals(my_name)==false)){%>
          <div id="duh">
            <p style="font-size: 20px;">Do you know <%=friend%>?<br>To know what he/she shares, send friend request</p>
            <form action="sent_request.jsp">
              <input type='hidden' name="req_uname" value="<%=friend%>">
              <input type='hidden' name="req_name" value="<%=my_realname%>">
              <input type="submit" value="Add friend" class="button" style="vertical-align:middle">
            </form>
          </div><%
        }
        
        else{
          %><center><p style="margin-top: 15px; font-size: 30px;">POSTS</p></center><%
          ResultSet rs3=stmt.executeQuery("select * from post where user_name='"+friend+"' order by datecolumn desc");
                            
                         while(rs3.next()){%>
                          <div id="post_img">
                              <div id="names_s2">
                              <h3 align="left" id="post_name">
                                <%=rs3.getString("name")%>
                              </h3>


                              <%String id1=rs3.getString("profilepic")+".jpg"; String fname1="./image/" ; String s1=fname1+id1;
                                if(rs3.getString("profilepic").equals("-")){%>
                                <img src="image/pimg.png" width="6%" style="
                                  float: left;
                                  margin-top: -35px;
                                  border-radius: 50%;
                                  margin-right: 15px;
                                ">
                                <% } else{%>
                                  <img src="<%=s1%>" width="6%" style="
                                    float: left;
                                    margin-top: -35px;
                                    border-radius: 50%;
                                    margin-right: 15px;
                                   ">
                                  <%}%>
                              <p style="font-size: 10px; opacity: 0.5; margin-left: 10px; margin-top: 3px;" align="left">
                                On <%=rs3.getString("datecolumn")%>
                              </p>
                              <hr style="margin-top: 10px;">
                              </div>
                              <%
                              if(rs3.getString("text") != null){%>
                              <pre>
                                <%=rs3.getString("text")%>
                              </pre>
                              <%}
                              String id=rs3.getString("post_id")+".jpg"; String fname="./image/";
                              if(rs3.getString("post_id") != null){
                                String s=fname+id; %>
                                <img  id="postimg" src="<%=s%>" height="300px" width="600px"><%
                              }
                              String n=rs3.getString("slnum");%>
                              <hr style="margin-top: 10px;">
                              <div id="like">
                                <% ResultSet rsn=stmt1.executeQuery("select count(*) from likes where post_id='"+n+"'");
                                while(rsn.next()){
                                  if(rsn.getInt("count(*)")==1){%>
                                  <p style="margin-left: 5px; margin-top: 10px;">
                                    <%=rsn.getInt("count(*)")%> like
                                  </p>
                                  <% } else if(rsn.getInt("count(*)")> 1){%>
                                    <p style="margin-left: 5px; margin-top: 10px;">
                                      <%=rsn.getInt("count(*)")%> likes
                                    </p>
                                  <%}
                                }%>
                              </div>
                              <div id="comment" style=" margin-left: 3px;">
                                <img src="comment.png" alt="" width="3%" class="commentbtn">
                                <div class="comment_body">
                                  <% ResultSet rsn2=stmt1.executeQuery("select * from comments where post_id='"+n+"' order by datecolumn desc");
                                    while(rsn2.next()){%>
                                    <p style="margin-top: 2px; margin-bottom: 2px;">
                                      <%=rsn2.getString("user_name")%> - <%=rsn2.getString("text")%>
                                    </p>
                                    <% }%>
                                </div>
                              </div>
                          </div>
                        <%}                            
          
        }%>
    </div>
  </div>
</body>
<script src="js/jquery.js"></script>
<script src="jqueryui/jquery-ui.js" type="text/javascript"></script>
<script>
 function loadNames() {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function () {
   if (this.readyState == 4 && this.status == 200) {
    var names = this.responseText;
    var str = names.split("&");
    $("#usernames").autocomplete({
     source: str
    }, {});
   }
  };
  xhttp.open("GET", "userName.jsp", true);
  xhttp.send();
 }

 $("document").ready(function () {

  $("#s1").accordion({
   collapsible: true,
   heightStyle: true,
  });

  $(".commentbtn").click(function () {
     $(this).next(".comment_body").slideToggle();
   });

 });
</script>
</html>