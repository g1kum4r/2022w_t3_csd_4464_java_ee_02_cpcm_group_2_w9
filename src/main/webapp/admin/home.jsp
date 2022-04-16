<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="sys.paymentbilling.model.PayRegister"%>
<%@page import="sys.paymentbilling.dao.PayRegisterDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/template/head-styles.jsp"></jsp:include>
<meta charset="ISO-8859-1">
<title>Admin</title>
</head>
<body>
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="container">
	<div class="row mt-4">
		<div class="col-md-12">
			<div class="d-flex flex-row justify-content-between align-items-center">
				<h4>Accountants</h4>
				<a href="<%=request.getContextPath().concat("/admin/create_accountant.jsp")%>" class="btn btn-dark">Create Accountant</a>
			</div>
			<%
				String error = request.getParameter("error");
				if(error != null && !error.isEmpty()){ %>
				<div class="alert alert-danger my-2 alert-dismissible fade show" role="alert">
					<%= error %>
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
				<% } %>
		</div>
	</div>
	<div class="row mt-4">
		<div class="col-md-12">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">Search Accountant</h5>
					<form class="">
						<div class="row">
							<div class="col-md-4">
								<div>
									<select name="branch" class="form-select" required="required">
										<%
										String branch = request.getParameter("branch");
												for (int i = 1; i < 10; i++) {
										%>
											<option <%if(branch != null 
												&& branch.equalsIgnoreCase(String.format("Branch %d", i))) {
													out.print("selected");
											}%>>
												<%=String.format("Branch %d", i)%></option>
										<%
										}
										%>
									</select>
								</div>
							</div>
							<div class="col-md-4">
								<div class="mb-2">
									<input type="search" name="search" value="<%=request.getParameter("search") != null ? request.getParameter("search"): ""%>" placeholder="Search" class="form-control">
								</div>
							</div>
							<input type="hidden" name="action" value="search">
							<div class="col-md-4">
								<span class="d-flex gap-2">
									<button type="submit" class="btn btn-dark">Search</button>
									<a href="<%=request.getContextPath().concat("/admin/home.jsp")%>" class="btn btn-light">Clear</a>
								</span>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="row mt-4">
		<div class="col-md-12">			
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Username</th>
						<th>Branch</th>
						<th>Date of joining</th>
						<th>Date of birth</th>
						<th>Salary</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
					String action = request.getParameter("action");
						List<PayRegister> users = new ArrayList<>();
						if (action != null && !action.isEmpty() && action.equalsIgnoreCase("search")){
							String search = request.getParameter("search");
							if(search != null && !search.isEmpty()){
						users = new PayRegisterDao().searcAccountants(search, request.getParameter("branch"));			
							} else {
						users = new PayRegisterDao().searcAccountants(request.getParameter("branch"));
						
							}
						}
						else {
							users = new PayRegisterDao().getAccountants();
						}
						if(users != null && users.isEmpty()){
					%><tr><td colspan="6">No Records found</td><%
					} else {
							for(PayRegister user: users){
					%><tr><td><%= user.getUsername() %></td><%
								%><td><%= user.getBranch() %></td><%
								%><td><%= user.getDateOfJoining() %></td><%
								%><td><%= user.getDateOfBirth() %></td><%
								%><td><%= user.getSalary() %></td><%
								%><td>
									<a href="<%= request.getContextPath().concat(String.format("/admin/accountant?action=edit&id=%d", user.getId())) %>" class="btn btn-sm btn-link" >edit</a>
									<a href="<%= request.getContextPath().concat(String.format("/admin/accountant?action=delete&id=%d", user.getId())) %>" class="btn btn-sm btn-danger">delete</a>
								</td></tr><%
							}		
						}
						
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>


</body>
</html>