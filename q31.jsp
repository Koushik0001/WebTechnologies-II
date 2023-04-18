<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.io.PrintWriter, java.io.IOException"%>

<%!
        static Connection connection;
        static PreparedStatement getAllTypesQuery;
        static PreparedStatement getManufacturersQuery;
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
                    String query1 = "SELECT roll, subject FROM marks WHERE semester=?";
                    String query2 = "SELECT marks FROM marks where roll=? and semester=?;";

                    getAllTypesQuery = connection.prepareStatement(query1, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    getManufacturersQuery = connection.prepareStatement(query2);
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
    .price{
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
  
  @keyframes shake {
    10%, 90% {
      transform: translate3d(-1px, 0, 0);
    }
  
    20%, 80% {
      transform: translate3d(2px, 0, 0);
    }
  
    30%, 50%, 70% {
      transform: translate3d(-4px, 0, 0);
    }
  
    40%, 60% {
      transform: translate3d(4px, 0, 0);
    }
  }
  
</style>
</head>
<body>
<%
    ResultSet rsTypes = getAllTypes();
    %><form id="componentsForm" action="scripts/q30_getReceipt.jsp" method="POST">
        <input type="text" name="query" value="receipt"/><%
    while(rsTypes.next()){
        String type = rsTypes.getString("type");
        %>
            <input class="componentFormField" type="text" id="<%=type%>_manufacturer" name="<%=type%>_manufacturer" value=""/>
            <input class="componentFormField" type="text" id="<%=type%>_model" name="<%=type%>_model" value=""/>
        <%
    }
    %></form><%
    rsTypes.beforeFirst();
    while(rsTypes.next()){
        String type = rsTypes.getString("type");
        %>
        <div class="container">
            <h2 style="text-align: center;">Select <%=type%></h2>
            <div class="row" id="<%=type%>ErrorLabel"></div>
            <div class="row">
                <div class="col-25">
                    <label for="<%=type%>ManufacturerDropdownBtn" style="font-size: 18px;">Select Manufacturer : </label>
                </div>
                <div class="col-75">
                    <div class="dropdown">
                        <button id="<%=type%>ManufacturerDropdownBtn" onclick="dropDownHandler('<%=type%>ManufacturerDropdown');" class="dropbtn">Select Manufacturer</button>
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
                    <button id="<%=type%>ModelDropdownBtn" onclick="dropDownHandler('<%=type%>ModelDropdown');modelDropDownHandler('<%=type%>')" class="dropbtn">Select Model</button>
                    <div id="<%=type%>ModelDropdown" class="dropdown-content">
                    </div>
                </div>
            </div>
            </div>

            <div class="row">
                <div class="col-25"></div>
                <div id="<%=type%>Price" class="col-75"></div>
            </div>
        </div>
        
    <%}
%>
    <%-- <div class="container">
        <div class="row" style="display:flex; justify-content: center;">
            <div id="mainErrorLabel"></div>
        </div>
        <div class="row" style="display:flex; justify-content: center;">
            <div><button id="submitBtn" onclick="submitBtnClicked();">Get the total price</button></div>
        </div>
    </div> --%>
    
    <div class="row">
            <div class="col-25"></div>
            <div class="col-75"><button id="submitBtn" onclick="document.getElementById('componentsForm').submit();">Get the total price</button></div>
    </div>
<script>
    
    function dropDownHandler(elementId){
        const elements = document.querySelectorAll('.show');
        const e = document.getElementById(elementId);
        elements.forEach(element => {
            if(e != element )
                element.classList.remove('show');
        });
        e.classList.toggle('show');
    }
    function modelDropDownHandler(type){
        if(document.getElementById(type+"ManufacturerDropdownBtn").textContent.split(" ")[0] == "Select"){
            document.getElementById(type+"ErrorLabel").textContent = "Select a manufacturer first";
            document.getElementById(type+"ManufacturerDropdownBtn").focus();
            document.getElementById(type+"ErrorLabel").classList.add("error");
        }
        else{
            document.getElementById(type+"ErrorLabel").textContent = "";
            if(document.getElementById(type+"ErrorLabel").classList.contains("error"))
                document.getElementById(type+"ErrorLabel").classList.remove("error");
        }
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
        function selectedManufacturerDropdown(type, selectedManufaturer){
            document.getElementById(type+"ErrorLabel").textContent = "";
            if(document.getElementById(type+"ErrorLabel").classList.contains("error"))
                document.getElementById(type+"ErrorLabel").classList.remove("error");
            document.getElementById(type+"ManufacturerDropdownBtn").textContent = selectedManufaturer;
            document.getElementById(type+"_manufacturer").value = selectedManufaturer;

            document.getElementById(type+"ModelDropdownBtn").textContent = "Select Model";
            document.getElementById(type+"_model").value = "";

            document.getElementById(type+"Price").classList.remove("price");
            document.getElementById(type+"Price").textContent = "";
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "scripts/q30_getComponentInfo.jsp?query=model&type="+type+"&manufacturer="+selectedManufaturer);
            xhr.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
              var models = JSON.parse(this.responseText)["models"];
              var output = document.getElementById(type+"ModelDropdown");
              output.innerHTML = "";
              for (index in models) {
                var buttonElement = document.createElement("button");
                buttonElement.setAttribute("class", "dropdown-button");
                buttonElement.setAttribute("type", "button");
                buttonElement.setAttribute("name", type+"Manufacturer");
                buttonElement.setAttribute("value", models[index]);
                buttonElement.setAttribute("onclick", "selectedModelDropdown('"+type+"','"+selectedManufaturer+"','"+models[index]+"');document.getElementById('"+type+"_model').value='"+models[index]+"'");
                buttonElement.textContent = models[index];
                output.appendChild(buttonElement);
              }
            }
          };
          xhr.send();
        }

       

    function selectedModelDropdown(type, manufacturer, model){
            document.getElementById(type+"ModelDropdownBtn").textContent = model;
            document.getElementById(type+"Price").textContent = "";
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "scripts/q30_getComponentInfo.jsp?query=price&type="+type+"&manufacturer="+manufacturer+"&model="+model);
            xhr.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
              var price = JSON.parse(this.responseText)["price"];
              var output = document.getElementById(type+"Price");
              output.classList.add("price");
              output.innerHTML = "Price: &#8377;"+numberWithCommas(price);
            }
          };
          xhr.send();
        }
    // function submitBtnClicked(){
    //     const formFields = document.querySelectorAll('.componentFormField');
    //     var submit=1;
    //     submit = formFields.forEach(formField => {
    //         if(formField.value == "" ){
    //             var errorLable = document.getElementById("mainErrorLabel");
    //             errorLable.classList.add("error");
    //             errorLable.innerHTML = "Both manufacturer and model of a component or none must be filled";
    //             shakeInput(formField.id);
    //             return 0;
    //         }
    //     });
    //     if(submit!==0)
    //         document.getElementById('componentsForm').submit();
    // }

    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    async function shakeInput(elementname) {
            const inputField = document.getElementById(elementname);
            inputField.classList.add('shake-animation');

            setTimeout(function () {
                inputField.classList.remove('shake-animation');
            }, 450);
        }
    </script>
    <div style="width: 100%; margin: auto; text-align: center; margin-top: 80px; padding-left: 35px;"><a href="."
      style="text-decoration: none;">#Go Back to Main menu</a></div>
</body>
</html>
