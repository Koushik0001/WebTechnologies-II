<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException"%>

<%!
        static Connection connection;
        static PreparedStatement getAllTypesQuery;
        static PreparedStatement getManufacturersQuery;
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
                    String query1 = "SELECT DISTINCT type FROM components";
                    String query2 = "SELECT DISTINCT manufacturer FROM components where type=?;";
                    String query3 = "SELECT model FROM components WHERE type=? and manufacturer=?";
                    String query4 = "SELECT price FROM components where type=? and manufacturer=? and model=?";

                    getAllTypesQuery = connection.prepareStatement(query1);
                    getManufacturersQuery = connection.prepareStatement(query2);
                    getModelsQuery = connection.prepareStatement(query3);
                    getPriceQuery = connection.prepareStatement(query4);
                }
        }
        private static ResultSet getAllTypes() throws SQLException, Exception {
            ResultSet rs = getAllTypesQuery.executeQuery();
            return rs;
        }
        private static ResultSet getManufacturers(String type) throws SQLException, Exception {
            getManufacturersQuery.setString(1, type);
            ResultSet rs = getManufacturersQuery.executeQuery();
            return rs;
        }
        private static ResultSet getModels(String type, String manufacturer) throws SQLException, Exception {
            getModelsQuery.setString(1, type);
            getModelsQuery.setString(2, manufacturer);
            ResultSet rs = getModelsQuery.executeQuery();
            return rs;
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

    try {
        connect(session ,server, port, databaseName, user, pass);
    }catch(Exception ex){out.println(ex);}
%>




<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="CSS/q23.css">

</head>
<body>

<%
    ResultSet rsTypes = getAllTypes();
    while(rsTypes.next()){
        String type = rsTypes.getString("type");
        %>
        <div class="container">
            <h2 style="text-align: center;">Select <%=type%></h2>
            <div class="row">
                <div class="col-25">
                    <label for="<%=type%>ManufacturerDropdownBtn" style="font-size: 18px;">Select Manufacturer : </label>
                </div>
                <div class="col-75">
                    <div class="dropdown">
                        <button id="<%=type%>ManufacturerDropdownBtn" onclick="document.getElementById('<%=type%>ManufacturerDropdown').classList.toggle('show');" class="dropbtn">Select Manufacturer</button>
                        <div id="<%=type%>ManufacturerDropdown" class="dropdown-content">
                        <%
                            ResultSet rsManufacturers = getManufacturers(type);
                            while(rsManufacturers.next()){
                                String manufacturer = rsManufacturers.getString("manufacturer");
                                %>
                                    <button type="button" class="dropdown-button" name="<%=type%>Manufacturer" value="<%=manufacturer%>" onclick="selectedManufacturerDropdown('<%=type%>','<%=manufacturer%>')">
                                        <%=manufacturer%>
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
                <label for="<%=type%>ModelDropdownBtn" style="font-size: 18px;">Select Model : </label>
            </div>
            <div class="col-75">
                <div class="dropdown">
                    <button id="<%=type%>ModelDropdownBtn" onclick="document.getElementById('<%=type%>ModelDropdown').classList.toggle('show');" class="dropbtn">Select Model</button>
                    <div id="<%=type%>ModelDropdown" class="dropdown-content">
                    </div>
                </div>
            </div>
            </div>

            <div class="row">
            <div id="<%=type%>Price"></div>
            </div>
        </div>
    <%}
%>

<script>
    /* When the user clicks on the button, 
    toggle between hiding and showing the dropdown content */
    function myFunction() {
      
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
        // onload = function(){
        //   var xhr = new XMLHttpRequest();
        //   xhr.open("GET", "scripts/q23_gethdd.jsp");
        //   xhr.onreadystatechange = function() {
        //     if (this.readyState === 4 && this.status === 200) {
        //       var hdd = JSON.parse(this.responseText)["hdd"];
        //       var output = document.getElementById("hddDropdown");
        //       output.innerHTML = "";
        //       for (index in hdd) {
        //         var buttonElement = document.createElement("button");
        //         buttonElement.setAttribute("class", "dropdown-button");
        //         buttonElement.setAttribute("type", "button");
        //         buttonElement.setAttribute("name", "state");
        //         buttonElement.setAttribute("value", hdd[index]["stateID"]);
        //         buttonElement.setAttribute("onclick", "selectedState(this.textContent, this.value)");
        //         buttonElement.textContent = hdd[index]["stateName"];
        //         output.appendChild(buttonElement);
        //       }
        //     }
        //   };
        //   xhr.send();
        // }
    
        function selectedManufacturerDropdown(type, selectedValue){
            document.getElementById(type+"ManufacturerDropdownBtn").textContent = selectedValue;
            document.getElementById(type+"ModelDropdownBtn").textContent = "Select Model";
            var xhr = new XMLHttpRequest();
            xhr.open("GET", `scripts/q23_getDistricts.jsp?state=${stateID}`);
            xhr.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
              var districts = JSON.parse(this.responseText)["districts"];
              var output = document.getElementById("districtsDropdown");
              output.innerHTML = "";
              for (index in districts) {
                var buttonElement = document.createElement("button");
                buttonElement.setAttribute("class", "dropdown-button");
                buttonElement.setAttribute("type", "button");
                buttonElement.setAttribute("name", "district");
                buttonElement.setAttribute("value", districts[index]["districtID"]);
                buttonElement.setAttribute("onclick", "selectedDistrict(this.textContent, this.value)");
                buttonElement.textContent = districts[index]["districtName"];
                output.appendChild(buttonElement);
              }
            }
          };
          xhr.send();
        }
    
        function selectedDistrict(districtName, districtID){
            document.getElementById("districtsDropdownBtn").textContent = districtName;
            const stateName = document.getElementById("hddDropdownBtn").textContent;
            var xhr = new XMLHttpRequest();
            xhr.open("GET", `scripts/q23_getDistrictInfo.jsp?district=${districtID}`);
            xhr.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
              var districtInfo = JSON.parse(this.responseText)["districtInfo"];
              var output = document.getElementById("district-description");
              output.innerHTML = "";
                showInfo(stateName,districtName,districtInfo);
            }
          };
          xhr.send();
        }
    
        function showInfo(stateName,districtName, districtInfo) {
        const district_description = document.querySelector("#district-description");
        while (district_description.firstChild)
            district_description.removeChild(district_description.firstChild);
        district_description.classList.remove("active");
    
        district_description.classList.add("active");
    
        const heading = document.createElement("p");
        const ul = document.createElement("ul");
    
        heading.setAttribute("class", "heading");
        ul.setAttribute("class", "info-list");
        heading.appendChild(document.createTextNode(`State : ${stateName}, District : ${districtName}`));
        var i = 1;
        const info_wrapper = document.createElement("li");
        const bullet = document.createElement("div");
        const info_name = document.createElement("div");
    
        info_wrapper.setAttribute("class", "info-wrapper");
        bullet.setAttribute("class", "bullet");
        info_name.setAttribute("class", "info");
    
        bullet.innerHTML = i;
        info_name.innerText = districtInfo;
    
        info_wrapper.appendChild(bullet);
        info_wrapper.appendChild(info_name);
        ul.appendChild(info_wrapper);
    
        district_description.appendChild(heading);
        district_description.appendChild(ul);
    }
    </script>
    <div style="width: 100%; margin: auto; text-align: center; margin-top: 80px; padding-left: 35px;"><a href="."
      style="text-decoration: none;">#Go Back to Main menu</a></div>
</body>
</html>
