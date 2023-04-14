<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>

    </style>
</head>
<body>
    <%
        String button = request.getParameter("buttonSubmit");
        int current = 0;
        if(request.getParameter("current") != null)
        {
            current = Integer.parseInt(request.getParameter("current"));
        }
    %>
    <form method="post" action="urlRewriting.jsp">
        Integer : <span id="hFieldInt"><%=current%></span>
        <a href="urlRewriting.jsp?current=<%=current-1%>"><button type="button">prev</button></a>
        <a href="urlRewriting.jsp?current=<%=current+1%>"><button type="button">next</button></a>
    </form>
    <a href="../q21.html">Go to main menu</a><br/>
</body>
</html>
</body>
</html>