import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Random;

public class SSEServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        response.setContentType("text/event-stream");
        response.setCharacterEncoding("UTF-8");
        int min = 100;
        int max = 900;
        Random random = new Random();
        PrintWriter printWriter = null;
        while (true) {
            try {                
                double stock1 = random.nextInt(max - min + 1) + min;
                double stock2 = random.nextInt(max - min + 1) + min;

                printWriter = response.getWriter();
                // printWriter.print("data: " + "[next server time check event in "+
                // Math.round(randomNumber/1000)+"seconds] \n");
                printWriter.print("event: stock1\n");
                printWriter.print("data: " + stock1 + "\n\n");

                printWriter.print("event: stock2\n");
                printWriter.print("data: " + stock2 + "\n\n");
                response.flushBuffer();
                Thread.sleep(1000);
            } catch (IOException | InterruptedException e) {
                printWriter.close();
                break;
            }
        }
    }
}