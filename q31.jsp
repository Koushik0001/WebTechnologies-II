<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException"%>

<%!
        static Connection connection;
        static PreparedStatement getAllSemsQuery;
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
                    String query1 = "SELECT DISTINCT semester FROM marks"; 
                    getAllSemsQuery = connection.prepareStatement(query1);
                }
        }
        private static ResultSet getAllSems() throws SQLException, Exception {
            ResultSet rs = getAllSemsQuery.executeQuery();
            return rs;
        }
%>
<%
    String server = "127.0.0.1";
    String port = "3306";
    String databaseName =  "test";
    String user = "user";
    String pass = "user1234";

    try {
        connect(session ,server, port, databaseName, user, pass);
    }catch(Exception ex){out.println(ex);}
%>




<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="CSS/q23.css">
<style>
    .marks{
        margin: 20px auto 0 auto;
        background-color: rgba(32, 170, 4, 0.296);
        border-radius: 5px;
        min-width: 66px;
        height: 46px;
        padding: 14px;
        text-align: center;
        font-family: monospace;
        font-size: 18px;
    }
    .row.error, #mainErrorLabel.error{
        text-align: center; margin:10px auto 20px auto
    }
    #submitBtn {
        border: 2px solid black;
        background-color: white;
        color: black;
        padding: 14px 28px;
        font-size: 16px;
        cursor: pointer;
        border-color: #04AA6D;
        color: green;
        border-radius:5px;
    }

    #submitBtn:hover {
    background-color: #04AA6D;
    color: white;
    }
    form{
        display: none;
    }
    .shake-animation {
    animation: shake 0.3s cubic-bezier(.36,.07,.19,.97) infinite;
  }
  .error{
    width: 
  }
  
</style>
</head>
<body>
    <div class="container">
        <h2 style="text-align: center;">Marks Information</h2>
        <div class="row">
            <div class="col-25">
                <label for="semsDropdownBtn" style="font-size: 18px;">Select semester from dropdown : </label>
            </div>
            <div class="col-75">
                <div class="dropdown">
                    <button id="semsDropdownBtn" onclick="dropDownHandler('semsDropdown');" class="dropbtn">Select Semester</button>
                    <div id="semsDropdown" class="dropdown-content">
                    <%
                        ResultSet rsSems = getAllSems();
                        while(rsSems.next()){
                            String semester = rsSems.getString("semester");
                        %>
                            
                            <button type="button" class="dropdown-button" name="sem" value="<%=semester%>" onclick="selectedSem('<%=semester%>')">
                                <%=semester.equals("sem_1")?"Semester 1":"Semester 2"%>
                            </button>
                        <%
                        }
                    %>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-25">
                <label for="rollsDropdownBtn" style="font-size: 18px;">Select roll no. from the dropdown : </label>
            </div>
            <div class="col-75">
                <div class="dropdown">
                    <button id="rollsDropdownBtn" onclick="dropDownHandler('rollsDropdown');" class="dropbtn">Select Roll No.</button>
                    <div id="rollsDropdown" class="dropdown-content">
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-25">
                <label for="subjectsDropdownBtn" style="font-size: 18px;">Select subject from the dropdown : </label>
            </div>
            <div class="col-75">
                <div class="dropdown">
                    <button id="subjectsDropdownBtn" onclick="dropDownHandler('subjectsDropdown');" class="dropbtn">Select Subject</button>
                    <div id="subjectsDropdown" class="dropdown-content">
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-25"></div>
            <div id="marks-description" class="col-75"></div>
        </div>
    </div>

<script>
    /* When the user clicks on the button, 
    toggle between hiding and showing the dropdown content */
    
    function dropDownHandler(elementId){
        const elements = document.querySelectorAll('.show');
        const e = document.getElementById(elementId);
        elements.forEach(element => {
            if(e != element )
                element.classList.remove('show');
        });
        e.classList.toggle('show');
    }
    // Close the dropdown if the user clicks outside of it
    window.onclick = function(event) {
      if (!event.target.matches('.dropbtn')) {
        var dropdowns = document.getElementsByClassName("dropdown-content");
        var i;
        for (i = 0; i < dropdowns.length; i++) {
          var openDropdown = dropdowns[i];
          if (openDropdown.classList.contains('show')) {
            openDropdown.classList.remove('show');
          }
        }
      }
    }
    </script>
    
    <script>
        function selectedSem(sem){
            document.getElementById("semsDropdownBtn").textContent = (sem==="sem_1")?"Semester 1":"Semester 2";
            document.getElementById("rollsDropdownBtn").textContent = "Select Roll";
            document.getElementById("subjectsDropdownBtn").textContent = "Select Subject";
            document.getElementById("marks-description").classList.remove("marks");
            document.getElementById("marks-description").textContent = "";
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "scripts/q31_getMarksInfo.jsp?query=roll&semester="+sem);
            xhr.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
              var rolls = JSON.parse(this.responseText)["rolls"];
              var output = document.getElementById("rollsDropdown");
              output.innerHTML = "";
              for (index in rolls) {
                var buttonElement = document.createElement("button");
                buttonElement.setAttribute("class", "dropdown-button");
                buttonElement.setAttribute("type", "button");
                buttonElement.setAttribute("name", "roll");
                buttonElement.setAttribute("value", rolls[index]);
                buttonElement.setAttribute("onclick", "selectedRoll('"+sem+"', this.value)");
                buttonElement.textContent = rolls[index];
                output.appendChild(buttonElement);
              }
            }
          };
          xhr.send();
        }
    
        function selectedRoll(sem, roll){
            document.getElementById("rollsDropdownBtn").textContent = roll;
            document.getElementById("subjectsDropdownBtn").textContent = "Select Subject";
            document.getElementById("marks-description").classList.remove("marks");
            document.getElementById("marks-description").textContent = "";
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "scripts/q31_getMarksInfo.jsp?query=subject&semester="+sem+"&roll="+roll);
            xhr.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
              var subjects = JSON.parse(this.responseText)["subjects"];
              var output = document.getElementById("subjectsDropdown");
              output.innerHTML = "";
              for (index in subjects) {
                var buttonElement = document.createElement("button");
                buttonElement.setAttribute("class", "dropdown-button");
                buttonElement.setAttribute("type", "button");
                buttonElement.setAttribute("name", "roll");
                buttonElement.setAttribute("value", subjects[index]);
                buttonElement.setAttribute("onclick", "selectedSubject('"+sem+"', '"+roll+"', this.value)");
                buttonElement.textContent = subjects[index];
                output.appendChild(buttonElement);
              }
            }
          };
          xhr.send();
        }
        function selectedSubject(sem, roll, subject){
            document.getElementById("subjectsDropdownBtn").textContent = subject;
            var xhr = new XMLHttpRequest();
         xhr.open("GET", "scripts/q31_getMarksInfo.jsp?query=marks&semester="+sem+"&roll="+roll+"&subject="+subject);
            xhr.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                var marks = JSON.parse(this.responseText)["marks"];
                var output = document.getElementById("marks-description");
                output.innerHTML = "";
                var output = document.getElementById("marks-description");
                output.classList.add("marks");
                output.innerHTML = "Marks: "+marks;
            }
          };
          xhr.send();
        }


        function showInfo(sem,roll,subject, marks) {
        const marks_description = document.querySelector("#marks-description");
        while (marks_description.firstChild)
            marks_description.removeChild(marks_description.firstChild);
        marks_description.classList.remove("active");
    
        marks_description.classList.add("active");
    
        const heading = document.createElement("p");
        const ul = document.createElement("ul");
    
        heading.setAttribute("class", "heading");
        ul.setAttribute("class", "info-list");
        heading.appendChild(document.createTextNode("Marks: "+marks));
        marks_description.appendChild(heading);
        marks_description.appendChild(ul);
    }
    </script>
    <div style="width: 100%; margin: auto; text-align: center; margin-top: 80px; padding-left: 35px;"><a href="."
      style="text-decoration: none;">#Go Back to Main menu</a></div>
</body>
</html>
