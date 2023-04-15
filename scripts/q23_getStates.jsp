<%@ page language="java" contentType="application/json; charset=UTF-8" %>
<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject"%>

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
                    String query1 = "SELECT stateID ,stateName FROM states;";
                    isPresentQuery = connection.prepareStatement(query1);
                }
        }
        private static JSONArray getStates() throws SQLException, Exception {
            JSONArray states = new JSONArray();
            ResultSet rs = isPresentQuery.executeQuery();
            while(rs.next()){
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("stateID", rs.getString("stateID"));
                jsonObject.put("stateName", rs.getString("stateName"));
                states.put(jsonObject);
            }
            return states;
        }
%>
<%
    String server = "127.0.0.1";
    String port = "3306";
    String databaseName =  "test";
    String user = "user";
    String pass = "user1234";
    response.setContentType("application/json");
    
    try {
        connect(session ,server, port, databaseName, user, pass);
    }catch(Exception ex){out.println(ex);}

    JSONObject jsonObject = new JSONObject();
    JSONArray jsonArray = getStates();
    jsonObject.put("states", jsonArray);
%>
    <%=jsonObject%>