import javax.xml.transform.*;
import javax.xml.transform.stream.*;

public class XmlToHtmlTransformer {
    public static void main(String[] args) {
        if (args.length < 3) {
            System.out.println("Usage: XmlToHtmlTransformer <xmlfile> <xsltfile> <htmlfile>");
            return;
        }

        String xmlFile = args[0];
        String xsltFile = args[1];
        String htmlFile = args[2];

        try {
            TransformerFactory factory = TransformerFactory.newInstance();
            Transformer transformer = factory.newTransformer(new StreamSource(xsltFile));
            transformer.transform(new StreamSource(xmlFile), new StreamResult(htmlFile));
            System.out.println("Transformation complete");
        } catch (TransformerException e) {
            System.out.println("Error transforming XML file: " + e.getMessage());
        }
    }
}

