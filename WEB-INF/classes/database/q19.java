package database;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class q19 extends HttpServlet {
   static Connection connection;
   static PreparedStatement allDepts;
   static PreparedStatement stringSearch;
   static PreparedStatement allStudentsOfDept;

   private static void connect(String connurl, String user, String pass, PrintWriter out) {
      String url = connurl;// "jdbc:mysql://localhost:3306/test";
      Properties info = new Properties();
      info.put("user", user);
      info.put("password", pass);

      try {
         new com.mysql.jdbc.Driver();
      } catch (Exception e) {
      }

      try {
         connection = DriverManager.getConnection(url, info);
         if (connection != null) {
            out.println("Connected to the database</br>");
            String query1 = "SELECT name, roll ,deptName from ( SELECT s.roll, s.name, d.deptName, s.deptID FROM stable as s INNER JOIN dtable as d ON s.deptID=d.deptID) as t WHERE t.name like CONCAT( '%',?,'%')";
            String query2 = "select deptName from dtable";
            String query3 = "SELECT roll, name FROM stable where deptID=?";

            stringSearch = connection.prepareStatement(query1);
            allDepts = connection.prepareStatement(query2);
            allStudentsOfDept = connection.prepareStatement(query3);

         }
      } catch (SQLException ex) {
         out.println("An error occurred. Maybe user/password is invalid");
         out.println(ex);
      }
   }

   private static ResultSet getNameWithString(String string) throws SQLException {
      stringSearch.setString(1, string);
      return stringSearch.executeQuery();
   }

   private static ResultSet getDepartments() throws SQLException {
      return allDepts.executeQuery();
   }

   private static ResultSet getStudentsOfDept(String department) throws SQLException {
      allStudentsOfDept.setString(1, department);
      return allStudentsOfDept.executeQuery();
   }

   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      response.setContentType("text/html");
      PrintWriter out = response.getWriter();

      String url = "jdbc:mysql://localhost:3306/test";// request.getParameter("connectionurl");
      String user = request.getParameter("user");
      String pass = request.getParameter("pass");
      String department = request.getParameter("dept");
      String string = request.getParameter("string");

      out.println("<html><body>");

      connect(url, user, pass, out);
      try {
         if (string.equals("") || string.equals(" ")) {
            out.println("<h3>give a string</h3>");
         } else {
            out.println("<h3>Students containing the strings: </h3>");
            out.println("<table>");
            out.print("<tr><th>Name</th><th>Roll</th><th>Department</th></tr>");
            ResultSet students = getNameWithString(string);
            while (students.next()) {
               String roll = students.getString("roll");
               String name = students.getString("name");
               String deptName = students.getString("deptName");
               out.print("<tr><th>" + name + "</th><th>" + roll + "</th><th>" + deptName + "</th></tr>");
            }
            out.println("</table>");
         }
         out.println("<h3>Departments: </h3>");
         out.println("<table>");
         out.print("<tr><th>Department</th></tr>");
         ResultSet departments = getDepartments();
         while (departments.next()) {
            String deptName = departments.getString("deptName");
            out.print("<tr><th>" + deptName + "</th></tr>");
         }
         out.println("</table>");

         if (department != null) {
            out.println("<h3>Students of Department "+ department +"</h3>");
            out.println("<table>");
            out.print("<tr><th>Name</th><th>Roll</th></tr>");
            ResultSet students2 = getStudentsOfDept(department);
            while (students2.next()) {
               String roll = students2.getString("roll");
               String name = students2.getString("name");
               out.print("<tr><th>" + name + "</th><th>" + roll + "</th></tr>");
            }
            out.println("</table>");
         }
         getStudentsOfDept(pass);
      } catch (SQLException ex) {
         out.println(ex);
      }

      out.println("</body></html>");

   }
}
