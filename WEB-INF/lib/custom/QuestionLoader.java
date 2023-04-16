package custom;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

public class QuestionLoader {
    
    private String fileName;
    private String jdbcUrl;
    private String username;
    private String password;
    
    public QuestionLoader(String fileName, String jdbcUrl, String username, String password) {
        this.fileName = fileName;
        this.jdbcUrl = jdbcUrl;
        this.username = username;
        this.password = password;
    }
    
    public void insert() throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
        
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document document = builder.parse(new File(fileName));
        NodeList questions = document.getElementsByTagName("question");
        
        for (int i = 0; i < questions.getLength(); i++) {
            Element question = (Element) questions.item(i);
            String no = question.getAttribute("no");
            String text = question.getElementsByTagName("text").item(0).getTextContent();
            String optionA = question.getElementsByTagName("optionA").item(0).getTextContent();
            String optionB = question.getElementsByTagName("optionB").item(0).getTextContent();
            String optionC = question.getElementsByTagName("optionC").item(0).getTextContent();
            String optionD = question.getElementsByTagName("optionD").item(0).getTextContent();
            Element answer = (Element) question.getElementsByTagName("answer").item(0);
            String value = answer.getAttribute("value");
            String query = "INSERT INTO questions (no, question, optionA, optionB, optionC, optionD, answer) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, no);
            statement.setString(2, text);
            statement.setString(3, optionA);
            statement.setString(4, optionB);
            statement.setString(5, optionC);
            statement.setString(6, optionD);
            statement.setString(7, value);
            
            statement.executeUpdate();
        }
        
        connection.close();
    }
}
