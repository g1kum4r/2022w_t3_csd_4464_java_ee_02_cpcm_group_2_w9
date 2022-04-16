<%@page import="sys.paymentbilling.dao.PayRegisterDao"%>
<%@page import="sys.paymentbilling.model.PayRegister"%>
<%@page import="org.apache.catalina.connector.Request"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/template/head-styles.jsp"></jsp:include>
<meta charset="ISO-8859-1">
<title>Accountant Form</title>
</head>
<body>
	<jsp:include page="/template/header.jsp"></jsp:include>
	<div class="container">
		<div class="row mt-4">
			<div class="col-md-12 d-flex flex-row justify-content-between align-items-center">
				<h4>Accountant Form</h4>
				<a href="<%=request.getContextPath().concat("/admin/home.jsp")%>" class="btn btn-dark">Search Accountant</a>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<%
				String status = request.getParameter("status");
				if (status != null && !status.isEmpty()) {
					%>
					<div class="alert alert-success my-2 alert-dismissible fade show" role="alert">
						<span class="fw-bold"><%= status %></span>
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
					<%
				} else {
					String error = request.getParameter("error");
					if (error != null && !error.isEmpty()) {
						%>
						<div class="alert alert-danger my-2 alert-dismissible fade show" role="alert">
							<span class="fw-bold"><%= error %></span>
							<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
						</div>
						<%
					}
				} 	
				String id = request.getParameter("id");
				PayRegister user = null;
				if (id != null && !id.isEmpty()) {
					user = new PayRegisterDao().getAccountant(Integer.parseInt(id));
					if (user == null) {
						%>
						<div class="alert alert-danger my-2 alert-dismissible fade show" role="alert">
							<span class="fw-bold">Account not found</span>
							<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
						</div>						
						<%
					}
				}
				%>
			</div>
		</div>
		<div class="row mt-4">
			<div class="col-md-4">
				<form class="d-grid gap-2"
					action="<%=request.getContextPath().concat("/admin/accountant")%>"
					method="post">
					<div>
						<label for="branch" class="form-label">Branch</label>
						<select name="branch" class="form-select" required="required">
							<%
							for (int i = 1; i < 10; i++) {
							%>
							<option
								<%if (user != null && user.getBranch().equalsIgnoreCase(String.format("Branch %d", i))) {
									out.print("selected");
								}%>>
								<%=String.format("Branch %d", i)%></option>
							<%
							}
							%>
						</select>
					</div>
					<div>
						<label for="username" class="form-label">Username</label>
						<input value="<%=user != null ? user.getUsername() : ""%>" type="text"
							name="username" class="form-control" required="required">
					</div>
					<div>
						<label for="password" class="form-label">Password</label>
						<input
							value="<%=user != null ? user.getPassword() : ""%>" type="password"
							name="password" class="form-control" required="required">
					</div>
					<div>
						<label for="dateOfJoining" class="form-label">Date of joining</label>
						<input
							value="<%=user != null ? user.getDateOfJoining() : ""%>"
							type="date" name="dateOfJoining" class="form-control" required="required">
					</div>
					<div>
						<label for="dateOfBirth" class="form-label">Date of birth</label>
						<input
							value="<%=user != null ? user.getDateOfBirth() : ""%>" type="date"
							name="dateOfBirth" class="form-control" required="required">
					</div>
					<div>
						<label for="salary" class="form-label">Salary</label>
						<input
							value="<%=user != null ? user.getSalary() : 0%>" type="number"
							name="salary" class="form-control" required="required">
					</div>
					<input type="hidden" name="id"
						value="<%=user != null ? user.getId() : ""%>">
					<button type="submit" class="btn btn-primary" >Save</button>
				</form>
			</div>
		</div>
	</div>

</body>
</html>