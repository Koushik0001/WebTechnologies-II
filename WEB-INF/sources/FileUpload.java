import java.io.*;
import java.sql.SQLException;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import custom.QuestionLoader;
/* The Java file upload Servlet example */

@MultipartConfig(
  fileSizeThreshold = 128, // 1 MB
  maxFileSize = 1024 * 1024 * 10,      // 10 MB
  maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class FileUpload extends HttpServlet {

  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    /* Receive file uploaded to the Servlet from the HTML5 form */
    Part filePart = request.getPart("file");
    String fileName = filePart.getSubmittedFileName();
    for (Part part : request.getParts()) {
      part.write("/Users/koushikmahanta/Desktop/Applications/apache-tomcat-9.0.71/webapps/km15623/ClientUploads/" + fileName);
    }
    response.getWriter().print("The file uploaded sucessfully.");
    try{
        new QuestionLoader("/Users/koushikmahanta/Desktop/Applications/apache-tomcat-9.0.71/webapps/km15623/ClientUploads/" + fileName,"jdbc:mysql://127.0.0.1:3306/test","user","user1234").insert();
    }catch(Exception ex){
        response.getWriter().print("Exception doing database insert. Description : " +ex);
    }
  }

}