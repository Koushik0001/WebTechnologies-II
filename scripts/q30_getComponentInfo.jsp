<%@ page language="java" contentType="application/json; charset=UTF-8" %>
<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject"%>


<%!
        static Connection connection;
        static PreparedStatement getModelsQuery;
        static PreparedStatement getPriceQuery;
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
                    String query1 = "SELECT model FROM components WHERE type=? and manufacturer=?";
                    String query2 = "SELECT price FROM components where type=? and manufacturer=? and model=?";

                    getModelsQuery = connection.prepareStatement(query1);
                    getPriceQuery = connection.prepareStatement(query2);
                }
        }
        private static JSONArray getModels(String type, String manufacturer) throws SQLException, Exception {
            JSONArray models = new JSONArray();
            getModelsQuery.setString(1, type);
            getModelsQuery.setString(2, manufacturer);
            ResultSet rs = getModelsQuery.executeQuery();
            while(rs.next()){
                models.put(rs.getString("model"));
            }
            return models;
        }
        private static int getPrice(String type, String manufacturer, String model) throws SQLException, Exception {
            getPriceQuery.setString(1, type);
            getPriceQuery.setString(2, manufacturer);
            getPriceQuery.setString(3, model);
            ResultSet rs = getPriceQuery.executeQuery();
            rs.next();
            return rs.getInt("price");
        }
%>
<%
    String server = "127.0.0.1";
    String port = "3306";
    String databaseName =  "test";
    String user = "user";
    String pass = "user1234";
    JSONObject jsonObject = new JSONObject();
    response.setContentType("application/json");
    String queryFor = request.getParameter("query");
    String type = request.getParameter("type");
    String manufacturer = request.getParameter("manufacturer");
    try {
        connect(session ,server, port, databaseName, user, pass);
        if(queryFor.equals("model")){
            JSONArray models = getModels(type, manufacturer);
            jsonObject.put("models",models);
        }
        else{
            String model = request.getParameter("model");
            int price = getPrice(type, manufacturer, model);
            jsonObject.put("price",price);
        }
    }catch(Exception ex){out.println(ex);}
%>
<%=jsonObject%>