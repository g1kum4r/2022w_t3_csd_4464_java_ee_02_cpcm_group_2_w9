<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<head>
	<meta charset="ISO-8859-1">
	<title><%= request.getAttribute("title") != null ? request.getAttribute("title"): request.getContextPath().substring(1) %></title>
</head>
