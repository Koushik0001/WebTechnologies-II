#!/usr/bin/python3

import os

print("Content-type: text/html\n\n")
print("<html>")
print("<head>")
print("<title>Environment Variables</title>")
print("</head>")
print("<body>")
print("<h1>Environment Variables</h1>")
print("<table>")
print("<tr><th>Variable</th><th>Value</th></tr>")
for var in os.environ:
    value = os.environ[var]
    print("<tr><td>{}</td><td>{}</td></tr>".format(var, value))
print("</table>")
print("</body>")
print("</html>")
