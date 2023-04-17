<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.Properties, java.sql.*, java.sql.Connection, java.time.LocalDate, java.time.format.DateTimeFormatter, java.util.Random, java.sql.DriverManager, java.text.DecimalFormatSymbols, java.text.DecimalFormat, java.io.PrintWriter, java.io.IOException, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject, java.util.Map"%>


<%!
        static Connection connection;
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
                    String query1 = "SELECT price FROM components where type=? and manufacturer=? and model=?";
                    getPriceQuery = connection.prepareStatement(query1);
                }
        }
        private static int getPrice(String type, String manufacturer, String model) throws SQLException, Exception {
            getPriceQuery.setString(1, type);
            getPriceQuery.setString(2, manufacturer);
            getPriceQuery.setString(3, model);
            ResultSet rs = getPriceQuery.executeQuery();
            rs.next();
            return rs.getInt("price");
        }
        private static String convertToPrice(double number) {
            DecimalFormatSymbols symbols = new DecimalFormatSymbols();
            symbols.setGroupingSeparator(',');
            DecimalFormat formatter = new DecimalFormat("#,##0.00", symbols);
            return formatter.format(number);
        }
        private static String getRandomIntegerString() {
            return Integer.toString(10000 + new Random().nextInt(90000));
        }
        private static String getTodaysDate() {
            LocalDate today = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM dd, yyyy");
            String formattedDate = formatter.format(today);
            return formattedDate;
        }

%>
<%
    String server = "127.0.0.1";
    String port = "3306";
    String databaseName =  "test";
    String user = "user";
    String pass = "user1234";
    
    response.setContentType("text/html");
    int totalPrice = 0;

    Map<String, String[]> parameters = request.getParameterMap();
    ArrayList<String> types = new ArrayList<>();
    for(String parameter : parameters.keySet()) {
        if(parameter.endsWith("model")) {
            //String[] values = parameters.get(parameter);
            //your code here
            types.add(parameter.substring(0, parameter.indexOf("_")));
        }
    }
    try {
        connect(session ,server, port, databaseName, user, pass);
%>
<html>
	<head>
		<meta charset="utf-8">
		<title>Invoice</title>
		<link rel="stylesheet" href="../CSS/q30_invoice.css">
	</head>
	<body>
		<header>
			<h1>Invoice</h1>
            <address>
				<p>Koushik Mahanta</p>
				<p>002011001106</p>
				<p>Information Technology</p>
			</address>
		</header>
		<article>
			<h1>Recipient</h1>
			<address>
				<p>Computer<br/>Components</p>
			</address>
			<table class="meta">
				<tr>
					<th><span>Invoice #</span></th>
					<td><span><%=getRandomIntegerString()%></span></td>
				</tr>
				<tr>
					<th><span>Date</span></th>
					<td><span><%=getTodaysDate()%></span></td>
				</tr>
			</table>
			<table class="inventory">
				<thead>
					<tr>
						<th><span>Component</span></th>
						<th><span>Manufacturer</span></th>
						<th><span>Model</span></th>
						<th><span>Price</span></th>
					</tr>
				</thead>
				<tbody>
                    <%for (String type : types) {
                        String manufacturer = parameters.get(type+"_manufacturer")[0];
                        String model = parameters.get(type+"_model")[0];
                        int price = getPrice(type, manufacturer, model);
                        totalPrice += price*1.0;
                    %>
					<tr>
						<td><span><%=type%></span></td>
						<td><span><%=manufacturer%></span></td>
						<td><span><%=model%></span></td>
						<td><span>&#8377;</span><span><%=convertToPrice(price)%></span></td>
					</tr>
                    <%}%>
				</tbody>
			</table>
			<table class="balance">
				<tr>
					<th><span>Total</span></th>
					<td><span data-prefix>&#8377;</span><span><%=convertToPrice(totalPrice)%></span></td>
				</tr>
			</table>
		</article>
	</body>
</html>
<%
}catch(Exception ex){out.println();}
%>