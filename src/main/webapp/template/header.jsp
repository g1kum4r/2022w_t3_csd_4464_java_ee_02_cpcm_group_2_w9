<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<img src="<%= request.getContextPath() %>/assets/img/banner-1.jpg" style="width:100%; max-height:230px; object-fit:cover">
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
	<div class="container">
		<ul class="navbar-nav ">
			<li class="nav-item">
				<a class="nav-link" href="<%= request.getContextPath() %>">HOME</a>
			</li>
			<li class="nav-item">
				<a class="nav-link">NEW REGISTERATTION</a>
			</li>
			<li class="nav-item">
				<a class="nav-link">MODIFY DETAIL</a>
			</li>
			<li class="nav-item">
				<a class="nav-link">ADMINISTRATOR</a>
			</li>
			<li class="nav-item">
				<a class="nav-link">CONTACT US</a>	
			</li>
		</ul>
		
		<%
		Object userIdObject = session.getAttribute("userId");
		if(userIdObject != null) {
			%>
				<ul class="navbar-nav ms-auto">
					<li class="nav-item">
						<a class="nav-link">
							<%= session.getAttribute("username") %>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%= request.getContextPath() %>/logout">Logout</a>
					</li>
				</ul>
			<%
		} %>
	</div>
</nav>
