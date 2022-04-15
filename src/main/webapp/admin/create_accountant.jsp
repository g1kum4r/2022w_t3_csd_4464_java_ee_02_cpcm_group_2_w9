<%@page import="sys.paymentbilling.dao.UserDao"%>
<%@page import="sys.paymentbilling.model.User"%>
<%@page import="org.apache.catalina.connector.Request"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin</title>
</head>
<body>
<jsp:include page="/template/header.jsp"></jsp:include>
<h1>Admin</h1>
<a href="<%= request.getContextPath().concat("/admin/home.jsp") %>">Search Accountant</a>
<%
	String status = request.getParameter("status");
	if(status != null && !status.isEmpty()){
			%><%= status %><%		
	} else {
		String error = request.getParameter("error");
		if(error != null && !error.isEmpty()) {
			%><%= error.toString() %><%
		}		
	}
	
	String id = request.getParameter("id");
	User user = null;
	if(id != null && !id.isEmpty()){
		user = new UserDao().getAccountant(Integer.parseInt(id));
		if(user == null) {
			%> Account not found <%			
		}
	}
%>


<form action="<%= request.getContextPath().concat("/admin/accountant") %>" method="post">
	<div>
		<label for="branch">Branch</label>
		<select name="branch" required="required">
			<% for (int i = 1; i < 10; i++) {%>
				<option <% if(user != null 
					&& user.getBranch().equalsIgnoreCase(String.format("Branch %d", i))) {
						out.print("selected");
				} %>>
					<%= String.format("Branch %d", i) %></option>
			<% } %>
		</select>
	</div>
	<div>
		<label for="username">Username</label>
		<input value="<%= user != null ? user.getUsername(): "" %>" type="text" name="username" required="required">
	</div>
	<div>
		<label for="password">Password</label>
		<input value="<%= user != null ? user.getPassword(): "" %>" type="password" name="password" required="required">
	</div>
	<div>
		<label for="dateOfJoining">Date of joining</label>
		<input value="<%= user != null ? user.getDateOfJoining(): "" %>" type="date" name="dateOfJoining" required="required">
	</div>
	<div>
		<label for="dateOfBirth">Date of birth</label>
		<input value="<%= user != null ? user.getDateOfBirth(): "" %>" type="date" name="dateOfBirth" required="required">
	</div>
	<div>
		<label for="salary">Salary</label>
		<input value="<%= user != null ? user.getSalary(): 0 %>" type="number" name="salary" required="required">
	</div>
	<input type="hidden" name="id" value="<%= user != null ? user.getId(): "" %>">
	<button type="submit">Save</button>
</form>

</body>
</html>