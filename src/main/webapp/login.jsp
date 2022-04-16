<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="/template/head-styles.jsp"></jsp:include>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body class="">
	<jsp:include page="/template/header.jsp"></jsp:include>
	<div class="container">
		<div class="row mt-3">
			<div class="col-md-4">
				<div class="d-flex flex-row justify-content-between align-items-center">
					<h4>Login Form</h4>
					<a href="<%= request.getContextPath() %>/admin/login.jsp">Login as Admin</a>					
				</div>
				<% String error = request.getParameter("error"); %>
				<% if(error != null && !error.isEmpty()) { %>
					<div class="alert alert-danger my-2 alert-dismissible fade show" role="alert" dismiss>
						<%= error %>
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				<% } %>
				<form action="<%= pageContext.getServletContext().getContextPath() %>/login" method="post">
					<div class="mb-2">
						<label class="form-label" for="username">Username</label>
						<input class="form-control" type="text" name="username" required="required">
					</div>
					<div class="mb-2">
						<label class="form-label" for="password">Password</label>
						<input class="form-control" type="password" name="password" required="required" >
					</div>
					<div class="d-grid">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>