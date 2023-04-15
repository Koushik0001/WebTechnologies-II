<%@ page import="custom.QuestionLoader" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>

<%
try{
    Part filePart = request.getPart("file");
    String fileName = filePart.getSubmittedFileName();
    for (Part part : request.getParts()) {
      part.write("/Users/koushikmahanta/Desktop/Applications/apache-tomcat-9.0.71/webapps/km15623/ClientUploads/" + fileName);
    }
    response.getWriter().print("The file uploaded sucessfully.");
    
        new QuestionLoader("/Users/koushikmahanta/Desktop/Applications/apache-tomcat-9.0.71/webapps/km15623/ClientUploads/" + fileName,"jdbc:mysql://127.0.0.1:3306/test","user","user1234").insert();
    }catch(Exception ex){
        response.getWriter().print("Exception doing database insert. Description : " +ex);
    }finally {
        System.out.println("gi");
    }
%>