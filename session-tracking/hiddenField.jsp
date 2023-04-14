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
</head>
<body>
    <%
        String button = request.getParameter("buttonSubmit");
        int toBeSent = 0;
        if( request.getParameter("integer") != null && !request.getParameter("integer").equals("null"))
        {
         int currentInteger = Integer.parseInt(request.getParameter("integer"));
        
            if(button.equals("prev"))
                toBeSent = --currentInteger;
            else
                toBeSent = ++currentInteger;
        }
    %>
    <form method="post" action="hiddenField.jsp">
        Integer : <span id="hFieldInt"><%=toBeSent%></span>
        <input type="hidden" name="integer" value="<%=toBeSent%>">
        <button type="submit" name="buttonSubmit" value="prev">prv</button>
        <button type="submit" name="buttonSubmit" value="next">next</button>
    </form>
    <a href="../q21.html">Go to main menu</a><br/>
</body>
</html>
</body>
</html>