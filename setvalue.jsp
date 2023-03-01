<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%
        String friend=request.getParameter("friend");
        session.putValue("msg_receiver",friend);
        out.print(friend);
        response.sendRedirect("chatbox.jsp");
    %>
</body>
</html>