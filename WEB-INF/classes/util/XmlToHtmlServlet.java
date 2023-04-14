package util;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class XmlToHtmlServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set the content type of the response to "text/html"
        response.setContentType("text/html");

        // Get the input.xml file from the webapp's root directory
        String xmlFilePath = getServletContext().getRealPath("/index.xml");
        File xmlFile = new File(xmlFilePath);

        // Get the transform.xslt file from the webapp's root directory
        String xsltFilePath = getServletContext().getRealPath("/index.xslt");
        File xsltFile = new File(xsltFilePath);
        try {
            // Create a TransformerFactory object to compile the XSLT stylesheet
            TransformerFactory transformerFactory = TransformerFactory.newInstance();

            // Use the TransformerFactory to create a Transformer object
            Transformer transformer = transformerFactory.newTransformer(new StreamSource(xsltFile));

            // Use the Transformer object to transform the input.xml file to HTML
            transformer.transform(new StreamSource(xmlFile), new StreamResult(response.getWriter()));

        } catch (Exception e) {
            // Handle any exceptions
            e.printStackTrace();
            PrintWriter out = response.getWriter();
            out.println("<html><head><title>Error</title></head><body><h1>Error</h1><p>" + e.getMessage()
                    + "</p></body></html>");
        }
    }
}
