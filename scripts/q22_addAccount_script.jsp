<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException"%>

<%!
        static Connection connection;
        static PreparedStatement insertStatement;
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
                    String insert = "INSERT INTO accounts VALUES(?, ?, ?, ?)";
                    insertStatement = connection.prepareStatement(insert);
                }
        }
        private static void insertAccount(String user, String pass, String email, String dept) throws SQLException {
            insertStatement.setString(1, user);
            insertStatement.setString(2, pass);
            insertStatement.setString(3, email);
            insertStatement.setString(4, dept);
            
            int count = insertStatement.executeUpdate();
        }
%>
<%
    String server = "127.0.0.1";
    String port = "3306";
    String databaseName =  "test";
    String dbuser = "user";
    String dbpass = "user1234";
    
    String user = request.getParameter("user");
    String pass = request.getParameter("pass");
    String email = request.getParameter("email");
    String dept = request.getParameter("dept");
    
        try {
            connect(session ,server, port, databaseName, dbuser, dbpass);

        if(user!=null && pass!=null && email!=null && dept!=null){
            insertAccount(user, pass, email, dept);
            %>
                <span class="error" aria-live="polite" style="color: rgb(52, 181, 13);">Account successfully added</span>
            <%
        }
        }catch(Exception ex){
            %>
            <p>
                <span class="error" aria-live="polite" >Some error ouccurred. Error description : </span></br>
                <span style="color:black; font-family:monospace; width:80%; margin:5px auto "><%=ex%></span>
            </p>
            <%
        }
%>