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
	<h1>Login</h1>
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
		<input type="hidden" name="role" value="ADMIN">
		<button type="submit">Login</button>
	</form>
</body>
</html>