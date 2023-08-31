<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="header.jsp"%>
</head>
<body style="background-image: url('<c:url value="/resources/images/bg_image.jpeg"/>');">
	<%@include file="cache-remove.jsp"%>
	
	<nav class="navbar">
		<div class="logo">
			<img src="<c:url value = "/resources/images/home/quiz_icon.png"/> ">
			Quiz<span>Vault</span>
		</div>
	</nav>
	
	<div class="container">
		<h1>Admin Log In</h1>
		<div class="box">
			<form action="adminForm" method="post">
				<i class="fa fa-envelope"></i> <input type="email" name="username"
					id="email" placeholder="Enter Your Username">
		</div>
		<div class="box">
			<i class="fa fa-key"></i> <input type="password" name="password"
				id="password" placeholder="Enter Your Password">
		</div>
		<input type="submit" class="mybtn" value="SIGN IN"> <br>
		<%
		String message = (String) request.getAttribute("message");
		if (message != null) {
			out.print(message);
		}
		%>
		</form>
	</div>
	<div></div>
</body>
</html>