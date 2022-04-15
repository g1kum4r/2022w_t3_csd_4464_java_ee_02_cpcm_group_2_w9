<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<nav>
	<a href="<%= request.getContextPath() %>">HOME</a>
	<a>NEW REGISTERATTION</a>
	<a>MODIFY DETAIL</a>
	<a>ADMINISTRATOR</a>
	<a>CONTACT US</a>	
	<%
	Object userIdObject = session.getAttribute("userId");
	if(userIdObject != null) {
		%>
			<%= session.getAttribute("username") %>
			<a href="<%= request.getContextPath() %>/logout">Logout</a>
		<%
	} %>
</nav>
