<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException, org.json.JSONArray, org.json.JSONObject"%>

<%!
        static Connection connection;
        static PreparedStatement checkStatement;
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
                    String check = "SELECT EXISTS(SELECT 1 FROM accounts WHERE username = ? and passwd=?)";
                    checkStatement = connection.prepareStatement(check);
                }
        }
        private static Boolean checkUser(String user, String pass) throws SQLException {
            checkStatement.setString(1, user);
            checkStatement.setString(2, pass);
                        
            ResultSet rs = checkStatement.executeQuery();
            rs.next();
            return rs.getInt(1)==1?true:false;
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
    
        try {
            connect(session ,server, port, databaseName, dbuser, dbpass);

        if(user!=null && pass!=null){
            if(checkUser(user, pass)){
                JSONObject obj = new JSONObject();
                obj.put("status","ok");
                out.print(obj);
            }
            else{
                JSONObject obj = new JSONObject();
                obj.put("status","failure");
                obj.put("message", "Authentication failure");
                out.print(obj);
            }
        }
        }catch(Exception ex){
            JSONObject obj = new JSONObject();
            obj.put("status","failure");
            obj.put("message", ex);
            out.print(obj);
        }
%>