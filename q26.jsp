<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException"%>

<%!
        static Connection connection;
        static PreparedStatement getQuestionsQuery;
        private static void connect(HttpSession session, String server, String port, String databaseName, String user, String pass) throws IOException, SQLException {

            new com.mysql.jdbc.Driver();
            
            session.setAttribute("server", server);
            session.setAttribute("port", port);
            session.setAttribute("databasename", databaseName);
            session.setAttribute("user", user);
            session.setAttribute("pass", pass);
            
            String url = "jdbc:mysql://"+server+":"+port+"/"+databaseName;

            Properties info = new Properties();
            info.put("user", user);
            info.put("password", pass);

                connection = DriverManager.getConnection(url, info);
                if (connection != null) {
                    String query1 = "SELECT no, question, optionA, optionB, optionC, optionD FROM questions;";
                    getQuestionsQuery = connection.prepareStatement(query1);
                }
        }
        private static ResultSet getQuestions() throws SQLException, Exception {
            ResultSet rs = getQuestionsQuery.executeQuery();
            return rs;
        }
%>
<%
    String server = "127.0.0.1";
    String port = "3306";
    String databaseName =  "test";
    String user = "user";
    String pass = "user1234";
    String stateID = request.getParameter("state");

    try {
        connect(session ,server, port, databaseName, user, pass);
    }catch(Exception ex){out.println(ex);}
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="CSS/q23.css" />

</head>
<body>
  
<div class="container">
    <h2 style="text-align: center;">Question Paper</h2>
    <form>
    <%
    ResultSet rs = getQuestions();
    while(rs.next()){
        %>
        <div class="row">
            <div class="col-25">
                <p>
                    <%=rs.getInt("no")%>. <%=rs.getString("question")%>
                </p>
                <input type="radio" name="answer<%=rs.getInt("no")%>" value="optionA%>"/>
                <label><%=rs.getString("optionA")%></label>
                <br/>
                <input type="radio" name="answer<%=rs.getInt("no")%>" value="optionB"/>
                <label><%=rs.getString("optionB")%></label>
                <br/>
                <input type="radio" name="answer<%=rs.getInt("no")%>" value="optionC"/>
                <label><%=rs.getString("optionC")%></label>
                <br/>
                <input type="radio" name="answer<%=rs.getInt("no")%>" value="optionD"/>
                <label><%=rs.getString("optionD")%></label>
                <br/>
            </div>
            <div class="col-75">
                
            </div>
        </div>
        <%
    }
    connection.close();
    %>
    <div class="container">
        <button type="submit" style="float:right;">Submit</button>
    </div>
    </form>
</div>


    <div style="width: 100%; margin: auto; text-align: center; margin-top: 80px; padding-left: 35px;"><a href="."
      style="text-decoration: none;">#Go Back to Main menu</a></div>
</body>
</html>



