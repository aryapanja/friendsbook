<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="yoloo.css">
    <link rel="stylesheet" href="jqueryui/jquery-ui.css">
    <link rel="stylesheet" href="jqueryui/jquery-ui.structure.css">
    <link rel="stylesheet" href="jqueryui/jquery-ui.theme.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  </head>
  <body>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.*" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <% Class.forName("oracle.jdbc.driver.OracleDriver"); Connection
    con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","XE","xe");
    String my_name=(String)session.getAttribute("username");
    String my_realname=(String)session.getAttribute("user_realname");
    String my_ppic ="./image/"+(String)session.getAttribute("user_profilepic")+".jpg";
    Statement stmt=con.createStatement();
    Statement stmt1=con.createStatement();
    %>
    <div class="navbar">
      <img src="logo.png" alt="" width="4%">
      <a href="settings.jsp">Settings</a>
      <a href="Login.html">Log out</a>
      <a href="yolo.jsp">Home</a>
      <%if(my_ppic.equals("./image/-.jpg")){ %>
        <img src="image/pimg.png" alt="hi" width="3%" style="float: right; border-radius: 50%; margin-top: 8px; margin-right: 10px;"><%
      }else{%>
        <img src="<%=my_ppic%>" alt="hi" width="3%" style="float: right; border-radius: 50%; margin-top: 8px; margin-right: 10px;"><%
      }%>
      <form method="POST" action="profile.jsp">
      <input type="text" name="usernames" id="usernames" onclick="loadNames()" placeholder="Search Friendsbook" required>
      <input type="image" id="search" src="search.png" alt="Submit" class="sear">
      </form>
    </div>

    <div class="container">


          <div id="s1">

                <h3>Friend suggestions</h3>


                <div>

                    <%
                        ResultSet rs1=stmt.executeQuery("select user_name,profile_id,name from users where user_name !='"+my_name+"' and user_name not in(select sender from request where receiver='"+my_name+"') and user_name not in(select receiver from request where sender='"+my_name+"') and user_name not in(select my_friend from friendlist where me='"+my_name+"')");
                    %>

                    <%while(rs1.next())
                    {
                    %>
                        <div id="friend_suggestion">
                              <p class="names">
                                <%=rs1.getString("name") %>
                              </p>

                                <%String id=rs1.getString("profile_id")+".jpg"; String fname="./image/"; String s=fname+id;
                                  if(rs1.getString("profile_id").equals("-")){%>
                                  <img src="image/pimg.png" width="20%" style="
                                                            
                                   float: right;
                                   margin-top: -15px;
                                   border-radius: 50%;
                                   margin-right: 15px; 
                                  ">
                                  <% } else{%>
                                    <img src="<%=s%>" width="20%" style="
                                      float: right;
                                      margin-top: -15px;
                                      border-radius: 50%;
                                      margin-right: 15px;
                                    ">
                                    <% }%>



                              <form action="sent_request.jsp" method="post">
                                <input type='hidden' name="req_uname" value="<%=rs1.getString("user_name") %>">
                                <input type='hidden' name="req_name" value="<%=my_realname%>">
                                <input class="buttons" type="Submit" value="Add friend">
                                <hr>
                              </form>
                        </div>
                    <% } %>
                </div>

                  <h3>Friend requests</h3>


                <div>

                    <% ResultSet rs=stmt.executeQuery("select * from request where receiver='"+my_name+"'");
                    %>
                    
                    <% while(rs.next()) { %>
                      <div id="requests">
                            <p class="names">
                              <%=rs.getString("sender_name") %>
                            </p>


                            <%String id=rs.getString("sender_profile_id")+".jpg"; String fname="./image/" ; String s=fname+id;
                              if(rs.getString("sender_profile_id").equals("-")){%>
                              <img src="image/pimg.png" width="20%" style="
                            
                                float: right;
                                margin-top: -15px;
                                border-radius: 50%;
                                margin-right: 15px;
                                                              
                              ">
                              <% } else{%>
                                <img src="<%=s%>" width="20%" style="
                                  float: right;
                                  margin-top: -15px;
                                  border-radius: 50%;
                                  margin-right: 15px;
                                  ">
                                <% }%>
                          


                            <form action="response_request.jsp" name="response" method="post">
                              <input type='hidden' name="send_name" value="<%=rs.getString("sender") %>">
                              <input type="Submit" class="buttons" name="accept" value="Accept" on>
                              <input type="Submit" class="buttons" name="delete" value="Delete">
                              <hr>
                            </form>
                      </div>
                    <% } %>
                    




                </div>



          </div>

          <div id="s2">
              <%ResultSet rs5=stmt.executeQuery("select * from users where user_name='"+my_name+"'");%>
              
              <div id="post_text">   
                  
                  <% while(rs5.next()){

                      String id1=rs5.getString("profile_id")+".jpg";
                         String fname1="./image/";
                         String s1=fname1+id1; 
                         if(rs5.getString("profile_id").equals("-")){ %>
                                  <img src="image/pimg.png" width="8%" style="
                                    float: left;
                                    margin-top: 6px;
                                    border-radius: 50%;
                                    margin-right: 16px;
                                    margin-left: 2px;
                                    ">
                                  <%
                         }
                        else{ %>
                                  <img src="<%=s1%>" width="8%" style="
                                    float: left;
                                    margin-top: 6px;
                                    border-radius: 50%;
                                    margin-right: 16px;
                                    margin-left: 2px;
                                    ">
                                  <%                                  
                        }

                    } %>


                    <form action="post1.jsp" method="post">
                      <textarea class="textbox" name="my_post" placeholder="What's in your mind,<%=my_name%>?" cols="80" rows="1" autofocus="none" required></textarea><br>
                      <input type="submit" value="Post" id="postbtn">
                    </form>

                    <form action="temp.jsp" method="post">
                      <input type="submit" id="postbtn" value="Add image" style="background-color: tomato; float: right; margin-top: -40px; margin-right: 430px;">
                    </form>
                    
              </div>
              
                <%ResultSet rs3=stmt.executeQuery("select * from post where user_name='"+my_name+"' or user_name in(select my_friend from friendlist where me='"+my_name+"') order by datecolumn");
                %>

              <div name="images_and posts">                    
                        <% while(rs3.next()){%>
                        <div id="post_img">
                            <div id="names_s2">
                              <h3 align="left" id="post_name">
                                <%=rs3.getString("name")%>
                              </h3>


                              <%String id1=rs3.getString("profilepic")+".jpg"; String fname1="./image/" ; String s1=fname1+id1;
                                if(rs3.getString("profilepic").equals("-")){%>
                                <img src="image/pimg.png" width="8%" style="
                                  float: left;
                                  margin-top: -35px;
                                  border-radius: 50%;
                                  margin-right: 15px;
                                ">
                                <% } else{%>
                                  <img src="<%=s1%>" width="8%" style="
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
                              <p class="hello">
                                  <%=rs3.getString("text")%>
                              </p>
                              <%}
                              String id=rs3.getString("post_id")+".jpg"; String fname="./image/";
                              if(rs3.getString("post_id") != null){
                                String s=fname+id; %>
                                <img  id="postimg" src="<%=s%>" height="300px" width="600px"><%
                              }
                              String n = rs3.getString("slnum");%>
                              <hr style="margin-top: 10px;">
                              <div id="like">
                                <%
                                ResultSet rsn=stmt1.executeQuery("select count(*) from likes where post_id='"+n+"'");
                                while(rsn.next()){
                                  if(rsn.getInt("count(*)")==1){%>
                                    <p style="margin-left: 5px;"><%=rsn.getInt("count(*)")%> like</p><%
                                  }
                                  else if(rsn.getInt("count(*)") > 1){%>
                                    <p style="margin-left: 5px;"><%=rsn.getInt("count(*)")%> likes</p><%
                                  }
                                }
                                ResultSet rsn1=stmt1.executeQuery("select * from likes where user_name='"+my_name+"' and post_id='"+n+"'");
                                int is_present = 0;
                                while(rsn1.next()){
                                  is_present = 1;
                                }
                                if(is_present==0){%>
                                    <input type="hidden" name="postid" value=<%=n%>>
                                    <img src="unliked.png" class="likes" width="6.5%">
                                    <%
                                }
                                else{%>
                                    <input type="hidden" name="postid" value=<%=n%>>
                                    <img src="liked.png" class="unlikes" width="6.5%">
                                    <%
                                }%>
                              </div>
                              <%String n1 = rs3.getString("slnum");%>
                              <div id="comment" style="margin-top: -38px; margin-left: 45px;">
                                <img src="comment.png" alt="" width="4%" class="commentbtn">
                                <div class="comment_body">
                                  <form action="commentin.jsp" method="POST">
                                    <textarea class="textbox1" name="comment" placeholder="Comment as <%=my_name%>" cols="80" rows="1" autofocus="none" required></textarea>
                                    <input type="hidden" name="postidd" value=<%=n%>>
                                  </form>
                                  <img src="comment_input.png" class="com_inp" width="5%">
                                  <% ResultSet rsn2=stmt1.executeQuery("select * from comments where post_id='"+n+"' order by datecolumn desc");
                                    while(rsn2.next()){%>
                                    <p style="margin-top: 2px; margin-bottom: 2px;">
                                      <%=rsn2.getString("user_name")%> - <%=rsn2.getString("text")%>
                                    </p>
                                    <% }%>
                                </div>
                              </div>
                      </div>
                      <%}%>                            
              </div>
          </div>

          <div id="s3" align=center>

              <% ResultSet rs2=stmt.executeQuery("select * from friendlist where me='"+my_name+"'");
              %><p id="s3_header">Friends</p><%
              while(rs2.next()){
              %>
              <div id="myfriends">
                <h3><%=rs2.getString("fullname") %></h3>


                <%String id=rs2.getString("profilepic")+".jpg";
                String fname="./image/" ;
                String s=fname+id;
                if(rs2.getString("profilepic").equals("-")){%>
                  <img src="image/pimg.png" width="20%" style="
                    float: left;
                    margin-top: -15px;
                    border-radius: 50%;
                    
                  ">
                  <% } else{%>
                  <img src="<%=s%>" width="20%" style="
                    float: left;
                    margin-top: -15px;
                    border-radius: 50%; 
                  ">
                <%}%>

                <form action="setvalue.jsp" method="post">
                    <input type='hidden' name="friend" value="<%=rs2.getString("my_friend") %>">
                    <input type="Submit" value="chat" class="buttons" id="s3btn">
                </form>
                <div style="margin-top: -56px; margin-right: -60px;">
                    <form action="remove.jsp" method="post">
                      <input type="hidden" name="friend" value="<%=rs2.getString("my_friend") %>">
                      <input type="Submit" class="buttonn" value="remove">
                    </form>
                </div>
                <hr>
              </div>
            <% } %>
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

    


    $("document").ready(function(){

      if (localStorage.getItem("changed_name") == "1") {
        alert("Name successfully changed");
        localStorage.setItem("changed_name", "0");
      }

      if(localStorage.getItem("flag") == "1"){
        $("#s2").scrollTop(localStorage.getItem("scrollY"));
        localStorage.setItem("scrollY", "0");
      }

      

      $("#s1").accordion({
        collapsible: true,
        heightStyle: true,
      });
      $(".commentbtn").click(function(){
        $(this).next(".comment_body").slideToggle();
      });

      $(".likes").click(function () {
        var pid = $(this).prev("input").attr("value");
        var pos = $("#s2").scrollTop();
        localStorage.setItem("scrollY", pos);
        $.ajax({
          url:"liking.jsp",
          type:'POST',
          data:{pid:pid},
          success:function() {
            localStorage.setItem("flag", "1");
            location.reload();
          }
        });
      });

      $(".unlikes").click(function () {
        var pid = $(this).prev("input").attr("value");
        var pos = $("#s2").scrollTop();
        localStorage.setItem("scrollY", pos);
        $.ajax({
          url: "unlike.jsp",
          type: 'POST',
          data: { pid: pid },
          success: function () {
            localStorage.setItem("flag", "1");
            location.reload();
          }
        });
      });

      $(".com_inp").click(function(){
        var pos = $("#s2").scrollTop();
        localStorage.setItem("scrollY", pos);
        $(this).prev("form").submit();
        localStorage.setItem("flag", "1");
      });

      $(".buttons").click(function(){
        localStorage.setItem("flag2", "1");
      });
    });
  </script>
</html>