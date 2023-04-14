<%
    //this is for session API
    session.invalidate();

    //this is for cookies.jsp
    Cookie[] cookies = request.getCookies();
    if (cookies != null)
        {
            for (Cookie cookie:cookies) 
            {
                if(cookie.getName().equals("current"))
                {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
    response.sendRedirect("../q21.html");
%>