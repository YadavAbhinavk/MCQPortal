<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="project.mcq.portal.entities.*"%>


<%
   // Set cache-control headers to prevent caching
   response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
   response.setHeader("Pragma", "no-cache"); // HTTP 1.0
   response.setDateHeader("Expires", 0); // Proxies

   // Your other JSP code here
%>
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
		String contextPath = request.getContextPath();
        response.sendRedirect(contextPath + "/home");
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
		<h4>Test name cannot be update later,so choose name only once.</h4>
			<div class="box">
				<input type="text" name="tag" placeholder="Enter Test Name" required>
			</div>

			<div class="box">
				<input type="number" name="questions"
					placeholder="Enter number of questions" min="1" max="20" required>
			</div>
			<input type="submit" class="btn" value="Submit">
			
			<span id="message">
			<%
			String msg = (String) request.getAttribute("message");
			if (msg != null) {%>
				<%= msg %>
			<%}
			%>
			</span>
			
		</form>
	</div>

	<script src="<c:url value="/resources/js/index.js"/>"></script>
</body>
</html>