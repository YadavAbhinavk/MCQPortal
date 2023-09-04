<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="project.mcq.portal.entities.*"%>
<%@page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="header.jsp"%>
</head>
<body>
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
			<button onclick="onclick1()">Press</button>
		</div>

		<ul class="nav-links" id="navLinks">

			<li><a href="<%=request.getContextPath()%>/admin_dashboard">View
					Dashboard</a></li>

		</ul>
		<div class="burger" onclick="toggleMenu();">
			<div class="line1"></div>
			<div class="line2"></div>
			<div class="line3"></div>
		</div>
	</nav>


	<%
	Question ques = (Question) request.getAttribute("questionToUpdate");

	%>
	<div class="ques_container">
		<div class="ques_form">
			<form
				action="<%=request.getContextPath()%>/updateForm/<%=ques.getQuestionId()%>/<%=ques.getTag()%>"
				method="post" id="form">

				<div class="box1">
					<div>
						<label for="ques_name">Question Name:</label>
					</div>
					<textarea name="ques_name" >
                         <%=ques.getQuestionName()%>
            </textarea>
				</div>

				<div class="box1">
					<div>
						<label for="option1">Option 1:</label>
					</div>
					<textarea name="option1"> <%=ques.getOption1()%></textarea> 
				</div>

				<div class="box1">
					<div>
						<label for="option2">Option 2:</label>
					</div>
					<textarea name="option2"> <%=ques.getOption2()%></textarea> 
				</div>

				<div class="box1">
					<div>
						<label for="option3">Option 3:</label>
					</div>
					<textarea name="option3"> <%=ques.getOption3()%></textarea> 
				</div>

				<div class="box1">
					<div>
						<label for="option4">Option 4:</label>
					</div>
					<textarea name="option4"> <%=ques.getOption4()%></textarea> 
				</div>

				<div class="box1">
						<div>
							<label for="answer">Answer:</label>
						</div>

						<select name="answer" id="cars">
							<option value="option1" <%= ques.getCorrectAnswer().equals("option1") ? "selected":"" %>>Option1</option>
							<option value="option2" <%= ques.getCorrectAnswer().equals("option2") ? "selected":"" %>>Option2</option>
							<option value="option3" <%= ques.getCorrectAnswer().equals("option3") ? "selected":"" %>>Option3</option>
							<option value="option4" <%= ques.getCorrectAnswer().equals("option4") ? "selected":"" %>>Option4</option>
						</select>

					</div>
				<input type="submit" value="Update" class="mybtn">
			</form>
		</div>
	</div>
	
<script>
function onclick1()
{
	confirm("welcome");
	}

window.onpopstate = function (event) {
    // This code will be executed when the back button is pressed
    alert('Back button pressed!');
    // You can add additional logic or actions here if needed
};
</script>

</body>
</html>