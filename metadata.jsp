<!--DBMetaData.jsp-->
<%@page import="java.sql.*, java.lang.reflect.*"%>
<%
	new com.mysql.jdbc.Driver();
	String url = "jdbc:mysql://localhost:3306/test";
	Connection con = DriverManager.getConnection(url, "root", "root1234");
	DatabaseMetaData md = con.getMetaData();
	Method[] methods = md.getClass().getMethods();
	Object[] param = new Object[0];
	out.println("<table border=\"1\">");
	for (int i = 0; i < methods.length; i++) {
		if (methods[i].getParameterTypes().length == 0) {
			if (methods[i].getReturnType() == Boolean.TYPE || methods[i].getReturnType() == String.class) {
				out.println("<tr>");
				out.println("<td>"+methods[i].getName() + "</td>");
				try {
				  out.println("<td>" + methods[i].invoke(md, param)+"</td>");
				}catch(Exception e) {out.println("<td>" + e+"</td>");}
				out.println("</tr>");
			}
		}
	}
	out.println("</table>");
%>
