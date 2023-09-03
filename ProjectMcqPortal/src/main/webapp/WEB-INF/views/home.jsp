<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="header.jsp"%>
</head>
<body>
	<%@include file="cache-remove.jsp"%>
	<%@include file="navbar.jsp"%>

	<!-- welcome content starts here -->
	<div class="welcome_section">
		<div class="text">
			<h1>Welcome to</h1>
			<h2>
				Quiz<span>Vault</span>
			</h2>
			<p>
				Join the fun with quizzes on C++, Python , Java and beyond. <br>
			<div class="span">because learning to code is like solving
				puzzles while sipping your favorite cup of coffee.</div>
			</p>
		</div>

	</div>
	<!-- welcome content ends here -->
	<br>

	<!-- Other sections and content -->
	<div class="help_container" id="steps">
		<h2>
			Easy <span style="color: rgb(185, 7, 255); font-size: 1.2em;">3
				Simple Steps</span>
		</h2>
		<div class="help_container_inside">
			<div>
				<img src="<c:url value="/resources/images/home/login-page.webp"/>"
					width="100px">
				<h2>Create your account</h2>
				<h4>Create and login to your account.</h4>
			</div>
			<div>
				<img src="<c:url value="/resources/images/home/Select_test.jpg"/>"
					height="300px" alt="">
				<h2>Select a test</h2>
				<h4>Select a quiz from the available quizes.</h4>
			</div>
			<div>
				<img src="<c:url value="/resources/images/home/quiz.png"/>" alt="">
				<h2>Quiz</h2>
				<h4>Give the selected Quiz</h4>
			</div>
		</div>
	</div>

	<script src="<c:url value="/resources/js/script.js"/>"></script>

</body>
</html>

