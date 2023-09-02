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
	<%
	User user = (User) session.getAttribute("user");
	if (user == null) {
		response.sendRedirect("home");
	}
	%>
	<nav class="navbar">
		<div class="logo">
			<img src="<c:url value = "/resources/images/home/quiz_icon.png"/> ">
			Quiz<span>Vault</span>
		</div>
	</nav>
	
	<%
	String tag = (String) request.getAttribute("tag");
	List<Question> listOfQuestions = (List) request.getAttribute("listOfQuestions");
	String message = (String) request.getAttribute("message");
	List<String> correct_ans = new ArrayList<String>();
	String isAvailable = (String) request.getAttribute("isAvailable");
	StringJoiner stringJoiner = new StringJoiner(", ");
	if (isAvailable != null) {
	%>
	
	<div class="start">
		<div class="quiz_header">Welcome to ${tag} test.
		<div>Time left = <span id="timer"></span></div>
		</div>
	</div>
	  
	<form action="<%=request.getContextPath()%>/processSelectedRadioValues/<%=tag %>"
		method="post" id = "testForm">
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
		<input type="hidden" name="submissionTime" id="submissionTime" />
		<button type="submit" value="Submit" class="quiz_button">Submit</button>
	
	
	

</form>
 <br>
<br>

<script>
var time = 2*<%=listOfQuestions.size()%>;

document.getElementById('timer').innerHTML =
	  time + ":" + 00;
	startTimer();


	function startTimer() {
	  var presentTime = document.getElementById('timer').innerHTML;
	  var timeArray = presentTime.split(/[:]+/);
	  var m = timeArray[0];
	  var s = checkSecond((timeArray[1] - 1));
	  if(s==59){m=m-1}
	  if(m<0){
	    return
	  }
	  
	  document.getElementById('timer').innerHTML =
	    m + ":" + s;
	  console.log(m)
	  setTimeout(startTimer, 1000);
	  
	}

	function checkSecond(sec) {
	  if (sec < 10 && sec >= 0) {sec = "0" + sec}; // add zero in front of numbers < 10
	  if (sec < 0) {sec = "59"};
	  return sec;
	}


document.getElementById("testForm").addEventListener("submit", function() {
	var submissionTimeField = document.getElementById("submissionTime");
	submissionTimeField.value = new Date().toISOString().split('T')[0]+" "+new Date().toTimeString().split(" ")[0];
})
	
	window.setInterval(function(){ 
		var submissionTimeField = document.getElementById("submissionTime");
		submissionTimeField.value = new Date().toISOString().split('T')[0]+" "+new Date().toTimeString().split(" ")[0];
    
	document.getElementById("testForm").submit();
        	
}, time*60*1000);
	
        		
        		

    </script>
</body>
</html>