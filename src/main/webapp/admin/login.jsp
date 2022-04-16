<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/template/head-styles.jsp"></jsp:include>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<jsp:include page="/template/header.jsp"></jsp:include>
	<div class="container">
		<div class="row mt-3">
			<div class="col-md-4">
				<div class="d-flex flex-row justify-content-between align-items-center">
					<h4>Admin Login</h4>
					<a href="<%= request.getContextPath() %>/login.jsp">Login as Accountant</a>
				</div>
				<% String error = request.getParameter("error"); %>
				<% if(error != null && !error.isEmpty()) { %>
					<div class="alert alert-danger my-2 alert-dismissible fade show" role="alert">
						<%= error %>
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				<% } %>
				<form action="<%= pageContext.getServletContext().getContextPath() %>/login" method="post">
					<div class="mb-2">
						<label for="username" class="form-label">Username</label>
						<input type="text" name="username" class="form-control" required="required">
					</div>
					<div class="mb-2">
						<label for="password" class="form-label">Password</label>
						<input type="password" name="password" class="form-control" required="required" >
					</div>
					<input type="hidden" name="role" value="ADMIN">
					<div class="d-grid">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</form>				
			</div>
		</div>
	</div>
</body>
</html>