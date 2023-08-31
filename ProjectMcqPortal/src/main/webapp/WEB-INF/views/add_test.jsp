<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="project.mcq.portal.entities.*"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="header.jsp"%>
</head>
<body
	style="background-image: url('<c:url value="/resources/images/bg_image.jpeg"/>');">
	<%@include file="cache-remove.jsp"%>
	<%
	Admin admin = (Admin) session.getAttribute("admin");
	if (admin == null) {
		response.sendRedirect("home");
	}
	%>


	<nav class="navbar">
		<div class="logo">
			<img src="<c:url value = "/resources/images/home/quiz_icon.png"/> ">
			Quiz<span>Vault</span>
		</div>
	</nav>


	<div class="container">
		<h1>Test Page</h1>
		<form action="testForm" method="post">
			<div class="box">
				<input type="text" name="tag" placeholder="Enter Tag">
			</div>

			<div class="box">
				<input type="number" name="questions"
					placeholder="Enter number of questions" min="0" max="50">
			</div>
			<input type="submit" class="btn" value="Submit">
		</form>
	</div>

	<script src="<c:url value="/resources/js/script.js"/>"></script>
</body>
</html>