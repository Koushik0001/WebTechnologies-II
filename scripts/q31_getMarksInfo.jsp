<%@ page language="java" contentType="application/json; charset=UTF-8" %>
<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject"%>

<%!
        static Connection connection;
        static PreparedStatement getRollsQuery;
        static PreparedStatement getSubjectsQuery;
        static PreparedStatement getMarksQuery;
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
                    String query1 = "SELECT DISTINCT roll FROM marks where semester=?";
                    String query2 = "SELECT subject FROM marks where semester=? and roll=?";
                    String query3 = "SELECT marks FROM marks where semester=? and roll=? and subject=?";
                    getRollsQuery = connection.prepareStatement(query1);
                    getSubjectsQuery = connection.prepareStatement(query2);
                    getMarksQuery = connection.prepareStatement(query3);
                }
        }
        private static JSONArray getRolls(String semester) throws SQLException, Exception {
            JSONArray rolls = new JSONArray();
            getRollsQuery.setString(1, semester);
            ResultSet rs = getRollsQuery.executeQuery();
            while(rs.next()){
                rolls.put(rs.getString("roll"));
            }
            return rolls;
        }
        private static JSONArray getSubjects(String semester, String roll) throws SQLException, Exception {
            JSONArray subjects = new JSONArray();
            getSubjectsQuery.setString(1, semester);
            getSubjectsQuery.setString(2, roll);
            ResultSet rs = getSubjectsQuery.executeQuery();
            while(rs.next()){
                subjects.put(rs.getString("subject"));
            }
            return subjects;
        }
        private static int getMarks(String semester, String roll, String subject) throws SQLException, Exception {
            getMarksQuery.setString(1, semester);
            getMarksQuery.setString(2, roll);
            getMarksQuery.setString(3, subject);
            ResultSet rs = getMarksQuery.executeQuery();
            rs.next();
            return rs.getInt("marks");
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
    String semester = request.getParameter("semester");

    try {
        connect(session ,server, port, databaseName, user, pass);
        if(queryFor.equals("roll")){
            JSONArray rolls = getRolls(semester);
            jsonObject.put("rolls", rolls);
        }
        else if(queryFor.equals("subject")){
            String roll = request.getParameter("roll");
            JSONArray subjects = getSubjects(semester, roll);
            jsonObject.put("subjects", subjects);
        } 
        else{
            String roll = request.getParameter("roll");
            String subject = request.getParameter("subject");
            int marks = getMarks(semester, roll, subject);
            jsonObject.put("marks",marks);
        } 
    }catch(Exception ex){out.println(ex);}
%>
<%=jsonObject%>