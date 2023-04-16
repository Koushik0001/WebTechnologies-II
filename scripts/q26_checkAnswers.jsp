<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException"%>

<%!
        static Connection connection;
        static PreparedStatement getAnswerQuery;
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
                    String query1 = "SELECT answer FROM questions WHERE no=?";
                    getAnswerQuery = connection.prepareStatement(query1);
                }
        }
        private static String getAnswer(int no) throws SQLException, Exception {
            getAnswerQuery.setInt(1,no);
            ResultSet rs = getAnswerQuery.executeQuery();
            rs.next();
            return rs.getString("answer");
        }
%>
<%
    String server = "127.0.0.1";
    String port = "3306";
    String databaseName =  "test";
    String user = "user";
    String pass = "user1234";
    int numberOfQuestions = Integer.parseInt(request.getParameter("numberOfQuestions"));

    try {
        connect(session ,server, port, databaseName, user, pass);
    }catch(Exception ex){out.println(ex);}
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../CSS/q23.css" />
<style>
    .btn-container{
        padding: 15px;
        margin: 10px;
        display: flex;
    justify-content: space-between;
    }
    .col-25{
        width:100%;
    }
</style>
</head>
<body>
  
<div class="container">
    <h2 style="text-align: center;">Result</h2>
    <%
    for(int i=1; i<=numberOfQuestions; i++){
        %>
        <div class="row" style="text-align: center">
            <div class="col-25">
                <div>
                    <%
                        String answer = getAnswer(i);
                        if(answer.trim().equals(request.getParameter("answer"+i).trim())){
                            %>Question no. <%=i%> : <span style="color: rgb(52, 181, 13);">Correct</span> answer<%
                        }
                        else{
                            %>Question no. <%=i%> : <span style="color: rgb(181, 13, 13);">Wrong</span> answer<%
                        }
                    %>
                </div>
            </div>
        </div>
        <%
    }
    connection.close();
    %>
    <div style="width: 100%; margin: auto; text-align: center; margin-top: 40px;">
        <a href="../q26.jsp" style="text-decoration: none;">Go to Question Paper</a>
    </div>
    <div class="btn-container">
    </div>
</div>


    <div style="width: 100%; margin: auto; text-align: center; margin-top: 80px; padding-left: 35px;"><a href="."
      style="text-decoration: none;">#Go Back to Main menu</a></div>
</body>
</html>

