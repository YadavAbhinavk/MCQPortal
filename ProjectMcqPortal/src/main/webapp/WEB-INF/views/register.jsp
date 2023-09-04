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
	Users user = (Users) session.getAttribute("user");
		if (user != null) {
			String contextPath = request.getContextPath();
	        response.sendRedirect(contextPath + "/user_dashboard");
		}
	%>
	<nav class="navbar">
		<div class="logo">
			<img src="<c:url value = "/resources/images/home/quiz_icon.png"/> ">
			Quiz<span>Vault</span>
		</div>
	</nav>

	<div class="container">
		<h1>User Registration</h1>
		<div class="box">
			<form action="registerForm" method="post">
				<input type="text" name="name" id=""
					placeholder="Enter your full name" oninput="validateName(this)" required>
					 <p id="nameError" style="color: red;text-shadow:none;"></p>
		</div>
		<div class="box">
			<input type="text" name="mobile" id=""
				placeholder="Enter mobile number" maxlength="10" oninput="validateMobileNumber(this)" required>
				<p id="mobileNumberError" style="color: red;text-shadow:none;"></p>
		</div>
		<div class="box">
			<input type="text" name="password" id="" placeholder="Enter password" maxlength="15" minlength="6" oninput="validatePassword(this)" required>
			<p id="passwordError" style="color: red;text-shadow:none;"></p>
		</div>
		<input type="submit" class="mybtn" value="Register">
		</form>
		<br>
		<%
		String message = (String) request.getAttribute("message");
		if (message != null) {
			out.print(message);
		}
		%>

	</div>
	<br>
	<br>
	
	<script src="<c:url value="/resources/js/index.js"/>"></script>
</body>
</html>