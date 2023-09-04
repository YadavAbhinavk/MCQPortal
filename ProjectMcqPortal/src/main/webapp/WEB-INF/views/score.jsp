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
<style>
#result
{
display:none;
}
tr:hover td 
{
background-color:inherit;
color:black;
}
</style>
</head>
<body>
<%@include file="cache-remove.jsp"%>
	<nav class="navbar">
		<div class="logo">
			<img src="<c:url value = "/resources/images/home/quiz_icon.png"/> ">
			Quiz<span>Vault</span>
		</div>
		<ul class="nav-links" id="navLinks">

			<li><a href="<%=request.getContextPath()%>/user_dashboard">View Dashboard</a></li>
		</ul>
		<div class="burger" onclick="toggleMenu();">
		<div class="line1"></div>
		<div class="line2"></div>
		<div class="line3"></div>
	</div>
	</nav>
	<%
	Integer score = (Integer) request.getAttribute("score");
	List<Question> listOfQuestions = (List) request.getAttribute("listOfQuestions");
	List<Integer> scores = (List) request.getAttribute("listOfScores");
	List<String> userAnswers = (List) request.getAttribute("selectedRadioValues");
	%>

	<div class="start">
		<div class="quiz_header">
			<h2 style="text-align: justify; font-size: 20px;">
				Your score is
				<%=score%></h2>

			<button onclick="unHideResult()" class="mybtn">View Results</button>
		</div>
	</div>


	<div id="result">

		<%
		if (listOfQuestions != null) {
			int index = 0;
			int size = listOfQuestions.size();
			for (int i = 0; i < size; i++) {
				index++;

				// Get the selected answer and correct answer
				String selectedAnswer = userAnswers.get(i);
				String correctAnswer = listOfQuestions.get(i).getCorrectAnswer();

				// Determine if the current answer is correct
				boolean isCorrect = selectedAnswer != null && selectedAnswer.equals(correctAnswer);
		%>
		<div class="quiz_container">
			<div class="quiz_header">
				<table>

					<h2 style="text-align: justify; font-size: 20px;">
						Question
						<%=index%>.
						<%=listOfQuestions.get(i).getQuestionName()%>
					</h2>

					<tr>
						<td><%=scores.get(i)%>/1 Points.</td>
					</tr>

					<tr
						<%="option1".equals(correctAnswer) ? "style='background:lightgreen;' " : ""%>
						<%="option1".equals(selectedAnswer) ? "style='background:skyblue;' " : ""%>>
						<td><input type="number" name="questionId"
							value=<%=listOfQuestions.get(i).getQuestionId()%> hidden />
							<p class="answer-para">
								<input class="show-answer" type="checkbox" id=<%=index%>
									name="answer<%=listOfQuestions.get(i).getQuestionId()%>"
									value="option1" class="chkbox"
									<%="option1".equals(correctAnswer) ? "checked disabled" : "disabled"%>
									<%="option1".equals(selectedAnswer) ? "checked disabled" : ""%>><%=listOfQuestions.get(i).getOption1()%></p>
						</td>
					</tr>
					
					<tr
						<%="option2".equals(correctAnswer) ? "style='background:lightgreen;' " : ""%>
						<%="option2".equals(selectedAnswer) ? "style='background:skyblue;' " : ""%>>
						<td>
							<p class="answer-para">
								<input class="show-answer" type="checkbox" id=<%=index%>
									name="answer<%=listOfQuestions.get(i).getQuestionId()%>"
									value="option2"
									<%="option2".equals(correctAnswer) ? "checked disabled" : "disabled"%>
									<%="option2".equals(selectedAnswer) ? "checked disabled" : ""%>><%=listOfQuestions.get(i).getOption2()%></p>
						</td>
					</tr>
					<tr
						<%="option3".equals(correctAnswer) ? "style='background:lightgreen;' " : ""%>
						<%="option3".equals(selectedAnswer) ? "style='background:skyblue;' " : ""%>>
						<td>
							<p class="answer-para">
								<input class="show-answer" type="checkbox" id=<%=index%>
									name="answer<%=listOfQuestions.get(i).getQuestionId()%>"
									value="option3"
									<%="option3".equals(correctAnswer) ? "checked disabled" : "disabled"%>
									<%="option3".equals(selectedAnswer) ? "checked disabled" : ""%>><%=listOfQuestions.get(i).getOption3()%></p>
						</td>
					</tr>
					<tr
						<%="option4".equals(correctAnswer) ? "style='background:lightgreen;' " : ""%>
						<%="option4".equals(selectedAnswer) ? "style='background:skyblue;' " : ""%>>
						<td>
							<p class="answer-para">
								<input class="show-answer" type="checkbox" id=<%=index%>
									name="answer<%=listOfQuestions.get(i).getQuestionId()%>"
									value="option4"
									<%="option4".equals(correctAnswer) ? "checked disabled" : " disabled"%>
									<%="option4".equals(selectedAnswer) ? "checked disabled" : ""%>><%=listOfQuestions.get(i).getOption4()%></p>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<%
		}
		}
		%>
	</div>
	<script src="<c:url value="/resources/js/index.js"/>"></script>
</body>
</html>