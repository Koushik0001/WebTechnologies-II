<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException"%>

<%!
        static Connection connection;
        static PreparedStatement isPresentQuery;
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
                    String query1 = "SELECT EXISTS(SELECT 1 FROM accounts WHERE username = ?)";
                    isPresentQuery = connection.prepareStatement(query1);
                }
        }
        private static Boolean isPresent(String user) throws SQLException {
            isPresentQuery.setString(1, user);
            ResultSet rs = isPresentQuery.executeQuery();
            rs.next();
            return rs.getInt(1)==1?true:false;
        }
%>
<%
    String server = "127.0.0.1";
    String port = "3306";
    String databaseName =  "test";
    String user = "user";
    String pass = "user1234";
    response.setContentType("text/plain");
    
        try {
            connect(session ,server, port, databaseName, user, pass);
        }catch(Exception ex){out.println(ex);}

    String username = request.getParameter("user");
    if(isPresent(username)){
        %>
            <span class="error" aria-live="polite">Username is not available</span>
        <%
    }
    else{
        %>
            <span class="error" aria-live="polite" style="color: rgb(52, 181, 13);">Username is available</span>
        <%
    }
%>