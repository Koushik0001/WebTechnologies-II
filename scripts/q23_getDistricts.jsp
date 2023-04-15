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
                    String query1 = "SELECT districtID ,districtName FROM districts WHERE stateID=?;";
                    isPresentQuery = connection.prepareStatement(query1);
                }
        }
        private static JSONArray getDistricts(String state) throws SQLException, Exception {
            JSONArray districts = new JSONArray();
            isPresentQuery.setString(1, state);
            ResultSet rs = isPresentQuery.executeQuery();
            while(rs.next()){
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("districtID", rs.getString("districtID"));
                jsonObject.put("districtName", rs.getString("districtName"));
                districts.put(jsonObject);
            }
            return districts;
        }
%>
<%
    String server = "127.0.0.1";
    String port = "3306";
    String databaseName =  "test";
    String user = "user";
    String pass = "user1234";
    response.setContentType("application/json");
    String stateID = request.getParameter("state");

    try {
        connect(session ,server, port, databaseName, user, pass);
    }catch(Exception ex){out.println(ex);}

    JSONObject jsonObject = new JSONObject();
    JSONArray jsonArray = getDistricts(stateID);
    jsonObject.put("districts", jsonArray);
%>
    <%=jsonObject%>
