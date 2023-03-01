<html>
 <head>
     <style>
         *{
             padding: 0;
             margin: 0;
         }
         body{
            background-color: #333333;
         }
         
         #main{
            display: inline-block;
            background-color: #ffffff;
            border-radius: 10px;
            padding: 40px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            box-shadow: 0px 5px 20px 1px #141414;
         }
         iframe{
             border:2px solid #333333;
             height: 60vh;
             width: 80vh;
         }

         #my_msg{
            outline: none;
            resize: none;
            border-radius: 10px;
            padding: 5px;
            overflow: hidden;
            border: 1px solid rgb(43, 43, 43);
            box-sizing: border-box;
            margin-top: 15px;
            margin-bottom: 2px;
            background-color: #333030;
            font-size: 20px;
            width: 90%;
            color: #ffffff;
            border: none;
         }

         #my_msg::placeholder{
             padding-bottom: 20px;
             color: white;
         }

         #bttn{
             float: right;
             margin-top: -30px;
             padding: 4px;
             padding-top: 2px;
             padding-bottom: 2px;
         }
         #bttn{
             cursor: pointer;
         }
         .navbar {
            overflow: hidden;
            background-color: #333333;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1;
            border-bottom: rgb(173, 173, 173) 1px solid;
        }
        .navbar a {
            float: left;
            display: block;
            color: #ffffff;
            text-align: center;
            padding: 10px 16px;
            text-decoration: none;
            font-size: 17px;
            float: right;
            background-color: #e94d4d;
            margin-right: 4px;
            margin-top: 10px;
            border-radius: 5px;
        }
        .navbar a:hover {
            opacity: 0.8;
        }
        .navbar img {
            float: left;
            margin-left: 5px;
        }
        .navbar img:hover {
            opacity: 0.9;
            cursor: pointer;
        }
        .navbar p {
            display: inline-block;
            font-size: 20px;
            margin-top: 30px;
            margin-left: 250px;
        }
        #usernames {
            width: 225px;
            height: 35px;
            margin-top: 15px;
            outline: none;
            resize: none;
            border-radius: 20px;
            font-size: 20px;
            padding: 5px;
            padding-left: 10px;
            color: #bbbbbb;
            background-color: #504e4e;
            border: none;
        }
        #usernames::placeholder {
            text-align: left;
            padding-left: 10px;
            font-size: 20px;
            color: #dad5d5cc;
        }
        #usernames:hover {
            background-color: #5f5d5d;
            border: #e94d4d 2px solid;
        }
        .ui-menu-item {
            background-color: #333333;
            color: #dad5d5cc;
            font-size: 20px;
            padding-bottom: 4px;
            padding-top: 4px;
        }
        .ui-menu-item .ui-menu-item-wrapper.ui-state-active {
            background: #5f5d5d !important;
            color: #ffffff !important;
            outline: none;
            border: none;
            border-radius: 10px;
        }
        input[type="image"] {
            border-radius: 50%;
            padding: 2px;
        }
        input[type="image"]:hover {
            background-color: #e94d4d;
            border: black 1px solid;
        }
        #sending{
            padding: 8px;
            outline: none;
            border-radius: 5px;
            border: none;
            background-color: rgb(185, 184, 184);
            float: right;
            margin-top: -35px;
        }
        #sending:hover{
            cursor: pointer;
            background-color: rgb(19, 185, 55);
        }

     </style>
 </head>
 <body>
    <%String my_name=(String)session.getAttribute("username");
    String my_realname=(String)session.getAttribute("user_realname");
    String my_ppic ="./image/"+(String)session.getAttribute("user_profilepic")+".jpg";%>
    <div class="navbar">
        <img src="logo.png" alt="" width="4%">
        <a href="Login.html">Log out</a>
        <a href="yolo.jsp">Back</a>
        <%if(my_ppic.equals("./image/-.jpg")){ %>
            <img src="image/pimg.png" alt="hi" width="3%" style="float: right; border-radius: 50%; margin-top: 8px; margin-right: 10px;">
    <% }else{%>
            <img src="<%=my_ppic%>" alt="hi" width="3%" style="float: right; border-radius: 50%; margin-top: 8px; margin-right: 10px;">
    <% }%>
            
    </div>
    <div id="main">
        <iframe id="disp" src="trial1.jsp" frameborder="1"></iframe>
            <form>
                <textarea id="my_msg" name="my_msg" columns="20" , rows="1" , placeholder="Type a message" required></textarea><br>
            </form>
            <button id="sending">send</button>
    </div>
</body>
<script src="js/jquery.js"></script>
<script>
    $("document").ready(function(){
        $("#sending").click(function(){
            var my_msg = $("#my_msg").val();
            my_msg = my_msg.trim();
            localStorage.setItem("flagg", "1");
            if(my_msg ==""){
                alert("Message cannot be empty!");
            }
            else{
                $.ajax({
                    url:"chat.jsp",
                    type: 'POST',
                    data:{my_msg:my_msg},
                    success: function(){
                        $("#my_msg").val("");
                    }
                });
            }
        });

    });
</script>
</html>