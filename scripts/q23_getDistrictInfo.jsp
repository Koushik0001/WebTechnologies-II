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
                    String query1 = "SELECT districtInfo FROM districts WHERE districtID=?;";
                    isPresentQuery = connection.prepareStatement(query1);
                }
        }
        private static JSONObject getDistrictInfo(String districtID) throws SQLException, Exception {
            isPresentQuery.setString(1, districtID);
            ResultSet rs = isPresentQuery.executeQuery();
            rs.next();
            JSONObject districtInfo = new JSONObject();
            districtInfo.put("districtInfo", rs.getString("districtInfo"));
            return districtInfo;
        }
%>
<%
    String server = "127.0.0.1";
    String port = "3306";
    String databaseName =  "test";
    String user = "user";
    String pass = "user1234";
    response.setContentType("application/json");
    String districtID = request.getParameter("district");

    try {
        connect(session ,server, port, databaseName, user, pass);
    }catch(Exception ex){out.println(ex);}

    JSONObject districtInfo = getDistrictInfo(districtID);
%>
    <%=districtInfo%>
