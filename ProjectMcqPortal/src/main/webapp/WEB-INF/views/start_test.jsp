<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="project.mcq.portal.entities.*"%>
<%@page import="java.util.*"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="header.jsp"%>
<link rel="stylesheet" href="<c:url value="/resources/css/css1.css" />">
</head>
<body style="background-image: url('<c:url value="/resources/images/bg_image.jpeg"/>');">
	<%@include file="cache-remove.jsp"%>
	
	<nav class="navbar">
		<div class="logo">
			<img src="<c:url value = "/resources/images/home/quiz_icon.png"/> ">
			Quiz<span>Vault</span>
		</div>
	</nav>
	
	<%
	List<Question> listOfQuestions = (List) request.getAttribute("listOfQuestions");
	String message = (String) request.getAttribute("message");
	List<String> correct_ans = new ArrayList<String>();
	String isAvailable = (String) request.getAttribute("isAvailable");
	StringJoiner stringJoiner = new StringJoiner(", ");
	if (isAvailable != null) {
	%>
	
	<div class="start">
		<div class="quiz_header">Welcome to ${tag} test.</div>
	</div>
	<form action="<%=request.getContextPath()%>/processSelectedRadioValues"
		method="post">
		<%
		if (listOfQuestions != null) {
			int index = 0;
			for (Question ques : listOfQuestions) {
				index++;

				correct_ans.add(ques.getCorrectAnswer());
		%>
		<div class="quiz_container">
			<div class="quiz_header">
				<table>

					<h2 style="text-align: justify; font-size: 20px;">
						Question
						<%=index%>.
						<%=ques.getQuestionName()%></h2>

					<tr>
						<td><input type="number" name="questionId"
							value=<%=ques.getQuestionId()%> hidden />
							<p class="answer-para">
								<input class="show-answer" type="radio" id=<%=index%>
									name="answer<%=ques.getQuestionId()%>" value="option1"><%=ques.getOption1()%></p>
						</td>
					</tr>

					<tr>
						<td>
							<p class="answer-para">
								<input class="show-answer" type="radio" id=<%=index%>
									name="answer<%=ques.getQuestionId()%>" value="option2"><%=ques.getOption2()%></p>
						</td>
					</tr>

					<tr>
						<td>
							<p class="answer-para">
								<input class="show-answer" type="radio" id=<%=index%>
									name="answer<%=ques.getQuestionId()%>" value="option3"><%=ques.getOption3()%></p>
						</td>
					</tr>

					<tr>
						<td>
							<p class="answer-para">
								<input class="show-answer" type="radio" id=<%=index%>
									name="answer<%=ques.getQuestionId()%>" value="option4"><%=ques.getOption4()%></p>
						</td>
					</tr>

					<input class="show-answer" type="radio" id=<%=index%>
						name="answer<%=ques.getQuestionId()%>" value="e" checked hidden />


				</table>
			</div>
		</div>
		<%
		}
		}
		}
		%>
		<br> <br>
		<button type="submit" value="Submit" class="quiz_button">Submit</button>
	</form>

	<br>
	<br>
	<div id="result"></div>
	<script>
		
	</script>
</body>
</html>