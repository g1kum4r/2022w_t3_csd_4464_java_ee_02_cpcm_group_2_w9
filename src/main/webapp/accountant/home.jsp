<%@page import="sys.paymentbilling.model.Student"%>
<%@page import="sys.paymentbilling.dao.StudentDao"%>
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
<title>Accountant</title>
</head>
<body>
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="container">
	<div class="row mt-4">
		<div class="col-md-12">
			<div class="d-flex flex-row justify-content-between align-items-center">
				<h4>Accountants</h4>
				<a href="<%=request.getContextPath().concat("/accountant/create_student.jsp")%>" class="btn btn-dark">Create Student</a>
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
					<h5 class="card-title">Search Students</h5>
					<form>
						<div class="row">
							<div class="col-md-4">
								<input type="search" name="search" value="<%=request.getParameter("search") != null ? request.getParameter("search"): ""%>"  class="form-control" >
								<input type="hidden" name="action" value="search">
							</div>
							<div class="col-md-4 d-flex gap-2">
								<button type="submit" class="btn btn-dark">Search</button>
								<a href="<%=request.getContextPath().concat("/accountant/home.jsp")%>" class="btn btn-light">Clear</a>
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
						<th>Name</th>
						<th>Course</th>
						<th>Mobile</th>
						<th>Fee Sub</th>
						<th>Fees</th>
						<th>Paid</th>
						<th>Balance</th>
						<th>Address</th>
						<th>Father Name</th>
						<th>Mother Name</th>
						<th>Date of joining</th>
						<th>Date of birth</th>
						<th>Qualification</th>
						<th>Trainer</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
				<%
				String action = request.getParameter("action");
					List<Student> users = new ArrayList<>();
					if (action != null && !action.isEmpty() && action.equalsIgnoreCase("search")){
						String search = request.getParameter("search");
						if(search != null && !search.isEmpty()){
							users = new StudentDao().getStudents(search);
						} else {
							users = new StudentDao().getStudents();			
						}
					}
					else {
						users = new StudentDao().getStudents();
					}
					if(users != null && users.isEmpty()){
						%><tr><td colspan="14">No Records found</td><%
					} else {
						for(Student user: users){
							%><tr><td><%= user.getName() %></td><%
							%><td><%= user.getCourse() %></td><%
							%><td><%= user.getMobile() %></td><%
							%><td><%= user.getFeeSub() %></td><%
							%><td><%= user.getFees() %></td><%
							%><td><%= user.getPaid() %></td><%
							%><td><%= user.getBalance() %></td><%
							%><td><%= user.getAddress() %></td><%
							%><td><%= user.getFatherName() %></td><%
							%><td><%= user.getMotherName() %></td><%
							%><td><%= user.getDateOfBirth() %></td><%
							%><td><%= user.getDateOfJoining() %></td><%
							%><td><%= user.getQualification() %></td><%
							%><td><%= user.getTrainer() %></td><%
							%><td class="">
								<span class="d-flex gap-2">
									<a href="<%= request.getContextPath().concat(String.format("/accountant/student?action=edit&id=%d", user.getId())) %>" class="btn btn-sm btn-link" >edit</a>
									<a href="<%= request.getContextPath().concat(String.format("/accountant/student?action=delete&id=%d", user.getId())) %>" class="btn btn-sm btn-danger" >delete</a>
								</span>
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