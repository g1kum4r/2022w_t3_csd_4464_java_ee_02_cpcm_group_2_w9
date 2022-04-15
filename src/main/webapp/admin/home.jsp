<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="sys.paymentbilling.model.User"%>
<%@page import="sys.paymentbilling.dao.UserDao"%>
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
<% 
	String error = request.getParameter("error");
	if(error != null && !error.isEmpty()){
		out.print(error);
	}
%>
<a href="<%= request.getContextPath().concat("/admin/create_accountant.jsp") %>">Create Accountant</a>
<form>
	<div>
		<label for="branch">Branch</label>
		<select name="branch" required="required">
			<% String branch = request.getParameter("branch");
			for (int i = 1; i < 10; i++) {%>
				<option <% if(branch != null 
					&& branch.equalsIgnoreCase(String.format("Branch %d", i))) {
						out.print("selected");
				} %>>
					<%= String.format("Branch %d", i) %></option>
			<% } %>
		</select>
	</div>
	<div>
		<label for="search">Search</label>
		<input type="search" name="search" value="<%= request.getParameter("search") != null ? request.getParameter("search"): "" %>" >
	</div>
	<input type="hidden" name="action" value="search">
	<button type="submit">Search</button>
	<a href="<%= request.getContextPath().concat("/admin/home.jsp") %>">Clear</a>
</form>

<table>
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
	List<User> users = new ArrayList<>();
	if (action != null && !action.isEmpty() && action.equalsIgnoreCase("search")){
		String search = request.getParameter("search");
		if(search != null && !search.isEmpty()){
			users = new UserDao().searcAccountants(search, request.getParameter("branch"));			
		} else {
			users = new UserDao().searcAccountants(request.getParameter("branch"));
			
		}
	}
	else {
		users = new UserDao().getAccountants();
	}
	if(users != null && users.isEmpty()){
		%><tr><td colspan="6">No Records found</td><%		
	} else {
		for(User user: users){
			%><tr><td><%= user.getUsername() %></td><%
			%><td><%= user.getBranch() %></td><%
			%><td><%= user.getDateOfJoining() %></td><%
			%><td><%= user.getDateOfBirth() %></td><%
			%><td><%= user.getSalary() %></td><%
			%><td>
				<a href="<%= request.getContextPath().concat(String.format("/admin/accountant?action=edit&id=%d", user.getId())) %>" >edit</a>
				<a href="<%= request.getContextPath().concat(String.format("/admin/accountant?action=delete&id=%d", user.getId())) %>" >delete</a>
			</td></tr><%
		}		
	}
	
%>
</tbody>
</table>

</body>
</html>