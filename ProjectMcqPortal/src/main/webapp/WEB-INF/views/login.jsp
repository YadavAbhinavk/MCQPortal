<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="project.mcq.portal.entities.*"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="header.jsp"%>
</head>
<body
	style="background-image: url('<c:url value="/resources/images/bg_image.jpeg"/>');">
	<%@include file="cache-remove.jsp"%>
	<%
	User user = (User) session.getAttribute("user");
	if (user != null) {
		response.sendRedirect("user_dashboard");
	}
	%>
	<nav class="navbar">
		<div class="logo">
			<img src="<c:url value = "/resources/images/home/quiz_icon.png"/> ">
			Quiz<span>Vault</span>
		</div>
	</nav>

	<div class="container">
		<h1>User Log In</h1>
		<div class="box">
			<form action="loginForm" method="post">
				<input type="text" name="mobile" id=""
					placeholder="Enter mobile number" required>
		</div>
		<div class="box">
			<i class="fa fa-key"></i><input type="password" name="password" id=""
				placeholder="Enter password" required>
		</div>
		<input type="submit" class="mybtn" value="Sign In" />
		<button class="mybtn">
			<a href="register">Register</a>
		</button>
		<br>
		<%
		String message = (String) request.getAttribute("message");
		if (message != null) {
			out.print(message);
		}
		%>
		<div>
</body>
</html>