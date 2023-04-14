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
        int current = 0;
        int display = 0;
        Cookie[] cookies = request.getCookies();
        boolean found = false;
        if (cookies != null)
        {
            for (Cookie cookie:cookies) 
            {
                if(cookie.getName().equals("current"))
                {
                    found = true;
                    current = Integer.parseInt(cookie.getValue());
                }
            }
        }
        if(found)
        {
            if(button != null)
            {
                if(button.equals("prev"))
                {
                    response.addCookie(new Cookie("current", Integer.toString(current-1)));
                    display = current-1;
                }
                else if(button.equals("next"))
                {
                    response.addCookie(new Cookie("current", Integer.toString(current+1)));
                    display = current + 1;
                }
            }
        }
        else
        {
            response.addCookie(new Cookie("current", "0".toString()));
        }
    %>
    <form method="post" action="cookies.jsp">
        Integer : <span><%=display%></span>
        <button type="submit" name="buttonSubmit" value="prev">prv</button>
        <button type="submit" name="buttonSubmit" value="next">next</button>
    </form>
    <a href="session_invalidate.jsp">Go to main menu</a><br/>
</body>
</html>
</body>
</html>