import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;

public class HelloWorld extends HttpServlet{
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html");

        PrintWriter out = response.getWriter();
        out.println("<h3 style='color: DarkOliveGreen'>Hello World</h3>");
    }
}