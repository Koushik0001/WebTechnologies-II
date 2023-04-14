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
  
        
        if (session.getAttribute("current") != null)
        {
            if(button != null)
            {
                current = (int)session.getAttribute("current");  

                if(button.equals("prev"))
                {
                    session.setAttribute("current", current-1);
                    display = current-1;
                }
                else if(button.equals("next"))
                {
                    session.setAttribute("current", current+1);
                    display = current + 1;
                }
            }
        }
        else
        {
            session.setAttribute("current", 0);
            display = 0;
        }
    %>
    <form method="post" action="sessionApi.jsp">
        Integer : <span><%=display%></span>
        <button type="submit" name="buttonSubmit" value="prev">prv</button>
        <button type="submit" name="buttonSubmit" value="next">next</button>
    </form>
    <a href="session_invalidate.jsp">Go to main menu</a><br/>
</body>
</html>
</body>
</html>