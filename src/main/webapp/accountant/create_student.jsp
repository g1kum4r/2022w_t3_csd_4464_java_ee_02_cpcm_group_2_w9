<%@page import="sys.paymentbilling.dao.StudentDao"%>
<%@page import="sys.paymentbilling.model.Student"%>
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
<title>Student Form</title>
</head>
<body>
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="container">
	<div class="row mt-4">
		<div class="col-md-12 d-flex justify-content-between align-items-center">
			<h4>Student Form</h4>
			<a href="<%=request.getContextPath().concat("/accountant/home.jsp")%>" class="btn btn-dark">Search Students</a>
		</div>
	</div>
	<div class="row mt-4">
		<div class="col-md-12">
			<%
				String status = request.getParameter("status");
				if(status != null && !status.isEmpty()){
			%>
			<div class="alert alert-success my-2 alert-dismissible fade show" role="alert">
				<span class="fw-bold"><%= status %></span>
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
			
			<%
			} else {
				String error = request.getParameter("error");
				if(error != null && !error.isEmpty()) {
					%>
					<div class="alert alert-danger my-2 alert-dismissible fade show" role="alert">
						<span class="fw-bold"><%= error %></span>
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>

					<%
				}		
			}
				
			String id = request.getParameter("id");
			Student student = null;
			if(id != null && !id.isEmpty()){
				student = new StudentDao().getStudent(Integer.parseInt(id));
				if(student == null) {
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
		<div class="col-md-12">
			<form action="<%= request.getContextPath().concat("/accountant/student/") %>" method="post">
				<div class="row gy-3">
					<div class="col-md-4">
						<label class="form-label" class="form-label" for="name">Name</label>
						<input class="form-control" value="<%= student != null ? student.getName(): "" %>" type="text" name="name" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="course">Course</label>
						<input class="form-control" value="<%= student != null ? student.getCourse(): "" %>" type="text" name="course" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="mobile">Mobile</label>
						<input class="form-control" value="<%= student != null ? student.getMobile(): "" %>" type="tel" name="mobile" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="feeSub">Fee Sub</label>
						<input class="form-control" value="<%= student != null ? student.getFeeSub(): "" %>" type="number" name="feeSub" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="fees">Fees</label>
						<input class="form-control" value="<%= student != null ? student.getFees(): "" %>" type="number" name="fees" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="paid">Paid</label>
						<input class="form-control" value="<%= student != null ? student.getPaid(): "" %>" type="number" name="paid" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="balance">Balance</label>
						<input class="form-control" value="<%= student != null ? student.getBalance(): "" %>" type="number" name="balance" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="address">Address</label>
						<input class="form-control" value="<%= student != null ? student.getAddress(): "" %>" type="text" name="address" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="fatherName">Father name</label>
						<input class="form-control" value="<%= student != null ? student.getFatherName(): "" %>" type="text" name="fatherName" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="motherName">Mother Name</label>
						<input class="form-control" value="<%= student != null ? student.getMotherName(): "" %>" type="text" name="motherName" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="dateOfBirth">Date of birth</label>
						<input class="form-control" value="<%= student != null ? student.getDateOfBirth(): "" %>" type="date" name="dateOfBirth" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="dateOfJoining">Date of Joining</label>
						<input class="form-control" value="<%= student != null ? student.getDateOfJoining(): "" %>" type="date" name="dateOfJoining" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="qualification">Qualification</label>
						<input class="form-control" value="<%= student != null ? student.getQualification(): "" %>" type="text" name="qualification" required="required">
					</div>
					<div class="col-md-4">
						<label class="form-label" for="trainer">Trainer</label>
						<input class="form-control" value="<%= student != null ? student.getTrainer(): "" %>" type="text" name="trainer" required="required">
					</div>
					<input type="hidden" name="id" value="<%= student != null ? student.getId(): "" %>">				
				</div>
				<div class="d-flex justify-content-end align-items-end">
					<span>
						<button class="btn btn-primary" type="submit">Save</button>
					</span>
				</div>
				
			</form>
		</div>
	</div>
</div>



</body>
</html>