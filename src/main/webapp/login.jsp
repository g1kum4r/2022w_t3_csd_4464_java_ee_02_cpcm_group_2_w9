<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<jsp:include page="/template/header.jsp"></jsp:include>
	<a href="<%= request.getContextPath() %>/admin/login.jsp">Login as Admin</a>
	<h1>Login Form</h1>
	<% String error = request.getParameter("error"); %>
	<% if(error != null && !error.isEmpty()) { %>
		<%= error %>
	<% } %>
	<form action="<%= pageContext.getServletContext().getContextPath() %>/login" method="post">
		<div>
			<label for="username">Username</label>
			<input type="text" name="username" required="required">
		</div>
		<div>
			<label for="password">Password</label>
			<input type="password" name="password" required="required" >
		</div>
		<button type="submit">Login</button>
	</form>
</body>
</html>