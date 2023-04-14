<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException"%>

<%!
        static Boolean connectionStatus = false;
        static Connection connection;
        static PreparedStatement allDepts;
        static PreparedStatement stringSearch;
        static PreparedStatement allStudentsOfDept;
        private static void connect(HttpSession session, String server, String port, String databaseName, String user, String pass) throws IOException, SQLException {
            if(connectionStatus == false)
            {
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
                        connectionStatus = true;

                        String query1 = "SELECT name, roll ,deptName from ( SELECT s.roll, s.name, d.deptName, s.deptID FROM stable as s INNER JOIN dtable as d ON s.deptID=d.deptID) as t WHERE t.name like CONCAT( '%',?,'%')";
                        String query2 = "select deptName, deptID from dtable";
                        String query3 = "SELECT roll, name FROM stable as s INNER JOIN dtable as d ON s.deptID=d.deptID where deptName=?";

                        stringSearch = connection.prepareStatement(query1);
                        allDepts = connection.prepareStatement(query2);
                        allStudentsOfDept = connection.prepareStatement(query3);
                    }
            }
        }
        private static void disConnect(HttpSession session) throws SQLException{
            connection.close();
            connectionStatus = false;
            session.invalidate();
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

        
%>
<%
    String server = request.getParameter("server");
    String port = request.getParameter("port");
    String databaseName =  request.getParameter("databasename");
    String user = request.getParameter("user");
    String pass = request.getParameter("pass");
    String connectionCommand = request.getParameter("connection");
    String deptName = request.getParameter("deptname");

    
    
    if(connectionCommand != null){
        try {
            if(connectionCommand.equals("connect"))
                connect(session ,server, port, databaseName, user, pass);
            else if(connectionCommand.equals("disconnect"))
                disConnect(session);
        }catch(Exception ex){out.println(ex);}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>
        First File
    </title>
    <link rel="stylesheet" href="CSS/q19.css">
</head>
    <body>
        <div class="row" style="background-color: #bbbbbb5c; border-radius: 5px">
            <form action="q19.jsp" method="post">
                <div class="column eight">
                    <label for="server" >Server :</label><br>
                    <%
                        if(connectionStatus)
                        {
                            %>
                                <input type="text" id="server" name="server" placeholder="127.0.0.1" value="<%=session.getAttribute("server")%>" style="width: 80px;"><br>
                            <%
                        }
                        else{
                            %>
                                <input type="text" id="server" name="server" placeholder="127.0.0.1" value="127.0.0.1" style="width: 80px;"><br>
                            <%
                        }
                    %>
                </div>

                <div class="column eight">
                    <label for="port">Port:</label><br>
                    <%
                        if(connectionStatus)
                        {
                            %>
                            <input type="text" id="port" name="port" value="<%=session.getAttribute("port")%>" style="width: 80px;"><br><br>
                            <%
                        }
                        else{
                            %>
                            <input type="text" id="port" name="port" value="3306" style="width: 80px;"><br><br>
                            <%
                        }
                    %>
                    
                </div>

                <div class="column eight">
                    <label for="databasename">Database Name:</label><br>
                    <%
                    if(connectionStatus)
                        {
                            %>
                            <input type="text" id="databasename" name="databasename" value="<%=session.getAttribute("databasename")%>" style="width: 80px;"><br><br>
                            <%
                        }
                        else{
                            %>
                            <input type="text" id="databasename" name="databasename" value="test" style="width: 80px;"><br><br>
                            <%
                        }
                    %>
                </div>
                
                <div class="column eight">
                    <label for="user">Username:</label><br>
                    <%
                        if(connectionStatus)
                        {
                            %>
                            <input type="text" id="user" name="user" value="<%=session.getAttribute("user")%>" style="width: 100px;"><br><br>
                            <%
                        }
                        else{
                            %>
                            <input type="text" id="user" name="user" value="root" style="width: 100px;"><br><br>
                            <%
                        }
                    %>
                    
                </div>

                <div class="column eight">
                    <label for="pass">Password:</label><br>
                    <%
                        if(connectionStatus)
                        {
                            %>
                            <input type="password" id="pass" name="pass" value="<%=session.getAttribute("pass")%>" style="width: 100px;"><br><br>
                            <%
                        }
                        else{
                            %>
                            <input type="password" id="pass" name="pass" style="width: 100px;"><br><br>
                            <%
                        }
                    %>
                    
                </div>

                <div class="column eight">
                    <button class="button" type="submit" name="connection" value="connect">Connect</button>
                </div>

                <div class="column eight">
                    <button class="button discon" type="submit" name="connection" value="disconnect">Disconnect</button>
                </div>

                <div class="column eight">
                    <%
                    if(connectionStatus){
                        %>
                            <div class="info success">
                                <p><strong>Status:</strong> Connected</p>
                            </div>
                        <%
                    }
                    else{
                        %>
                            <div class="info failure">
                                <p><strong>Status:</strong> Disconnected</p>
                            </div>
                        <%
                    }
                    %>
                </div>
            </form>
        </div>
        <%if(connectionStatus){
            %>
        <div class="row">
            <div class="column two" style="background-color:#bbbbbb5c;">
                <form action="q19.jsp" method="post">
                    <label for="string">Enter the string :</label><br>
                    <input type="text" id="string" name="string" style="margin:0">

                    <input type="submit" value="Submit" style="margin:10px">
                </form>

                <%
                    String string = request.getParameter("string");
                    if(string != null || session.getAttribute("string") != null){
                        if( string != null)
                            session.setAttribute("string", string);
                        try {
                            if (session.getAttribute("string").toString().equals("") || session.getAttribute("string").toString().equals(" ")) {
                                %><p>give a string</p><%
                            } else {
                                
                                ResultSet students = getNameWithString(session.getAttribute("string").toString());
                                int i=0;
                                while (students.next()) {
                                    if(i==0){
                                        %><p style="color:#3e8e41">Names of Students containing the string "<%=session.getAttribute("string").toString()%>" are : </p><%
                                        %><table><%
                                        %><tr><th>Name</th><th>Roll</th><th>Department</th></tr><%
                                    }
                                    String roll = students.getString("roll");
                                    String name = students.getString("name");
                                    String deptName1 = students.getString("deptName");
                                    %><tr><td><%=name%></td><td><%=roll%></td><td><%=deptName1%></td></tr><%
                                    i++;
                                }
                                if(i>0){%></table><%}
                                if(i == 0)
                                {
                                    %><p style="color:#aa0404">No name contains the string "<%=session.getAttribute("string").toString()%>".</p><%
                                }
                            }
                        }catch(Exception ex){out.println(ex);}
                    }
                    
                %>
            </div>
            <div class="column two" style="background-color:#bbbbbb5c;">
                <div class="dropdown">
                    <%
                        if(deptName != null){
                            %>
                                <button class="dropbtn"><%=deptName%></button>
                            <%
                        }
                        else{
                            %>
                                <button class="dropbtn">Choose a Department</button>
                            <%
                        }
                    %>
                    <form action="q19.jsp" method="post">
                        <div class="dropdown-content">          
                            <%
                                try{
                                    ResultSet departments = getDepartments();
                                    while (departments.next()) {
                                        String deptName2 = departments.getString("deptName");
                                    %>
                                            <button class="dropdown-button" type="submit" name="deptname" value="<%=deptName2%>"><%=deptName2%></button>
                                    <%
                                    }
                                }catch (Exception ex) {
                                out.println(ex);
                                }
                            
                            %>
                        </div>
                    </form>
                </div>
                <%
                    try{
                        if (deptName != null) {
                            session.setAttribute("deptname", deptName);
                        }
                        if(session.getAttribute("deptname") != null)
                        {
                        out.println("<p style='color:#3e8e41'>Students of Department of <span style='text-decoration: underline;font-weight:600'>"+ session.getAttribute("deptname").toString() +"</span> are : </p>");
                        out.println("<table>");
                        out.print("<tr><th>Name</th><th>Roll</th></tr>");
                        ResultSet students2 = getStudentsOfDept(session.getAttribute("deptname").toString());
                        while (students2.next()) {
                            String roll = students2.getString("roll");
                            String name = students2.getString("name");
                            out.print("<tr><td>" + name + "</td><td>" + roll + "</td></tr>");
                        }
                        out.println("</table>");
                        }
                    }catch (Exception ex) {
                    out.println(ex);
                    }
                        
                %>
            </div>
        </div>

        <%}%>
        <div style="width: 100%; margin: auto; text-align: center; margin-top: 80px; padding-left: 35px;"><a href="."
            style="text-decoration: none;">#Go Back to Main menu</a></div>
        
    </body>
</html>