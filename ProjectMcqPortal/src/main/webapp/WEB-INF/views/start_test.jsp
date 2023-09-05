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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
tr {
	border-bottom: none;
}
</style>
</head>
<body
	style="background-image: url('<c:url value="/resources/images/bg_image.jpeg"/>');">

	<%@include file="cache-remove.jsp"%>
	<%

	Users user = (Users) session.getAttribute("user");
		if (user == null) {
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

	<%
	String tag = (String) request.getAttribute("tag");
	List<Question> listOfQuestions = (List) request.getAttribute("listOfQuestions");
	Tests test = (Tests)request.getAttribute("test");
	List<String> correct_ans = new ArrayList<String>();
	StringJoiner stringJoiner = new StringJoiner(", ");
	if (test.getIsAvailable() != null) {
	%>

	<div class="start">
		<div class="quiz_header">
			Welcome to ${tag} test.
			<div>
				Time left = <span id="timer"></span>
			</div>
		</div>
	</div>

	  

	<form
		action="<%=request.getContextPath()%>/processSelectedRadioValues/<%= tag %>"
		method="post" id="testForm">

		<%
		if (!listOfQuestions.isEmpty()) {
			int index = 0;
			for (Question ques : listOfQuestions) {
				index++;

				correct_ans.add(ques.getCorrectAnswer());
		%>
		<div class="quiz_container">
			<div class="quiz_header">
				<table>

					<h2 style="text-align: justify; font-size: 18px;">
						Question
						<%=index%>. <span style="text-align: justify; font-size: 12px;"><%=ques.getQuestionName()%></span>
					</h2>

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
		<br> <br> <input type="hidden" name="submissionTime"
			id="submissionTime" />
		<button type="submit" value="Submit" class="quiz_button">Submit</button>
		</form>


<script>


	// Assuming time per question in seconds per question, adjust as needed
    var totalTimeInSeconds = <%= listOfQuestions.size() %> * <%= test.getTimePerQuestion() %>; 
    
    // Convert total time in seconds to minutes and seconds
    var totalMinutes = Math.floor(totalTimeInSeconds / 60);
    var totalSeconds = totalTimeInSeconds % 60;

	document.getElementById('timer').innerHTML =
		totalMinutes + ":" + (totalSeconds < 10 ? "0" : "") + totalSeconds;
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
	window.setTimeout(function(){ 
		var submissionTimeField = document.getElementById("submissionTime");
		submissionTimeField.value = new Date().toISOString().split('T')[0]+" "+new Date().toTimeString().split(" ")[0];
  
	document.getElementById("testForm").submit();
      	
},	totalTimeInSeconds*1000);
	
		// Flag to track form submission
		var formSubmitted = false;

		// Set the formSubmitted flag to true when the form is submitted
		document.getElementById("myForm").addEventListener("submit",
				function() {
					formSubmitted = true;
				});

		// Warn users when leaving the page without submitting the form
		window
				.addEventListener(
						"beforeunload",
						function(event) {
							if (!formSubmitted) {
								alert("You have an unfinished test. Are you sure you want to leave?");
							}
						});

		// ... (rest of the code)
		function checkTestStatus() {
        var tag = '<%=test.getTag()%>'; 
        console.log(tag);
        $.ajax({
            url: "<%=request.getContextPath()%>/checkTestStatus?tag="+tag, // URL to your checkTestStatus endpoint
            success: function(data) {
            	
                if (data === 'inactive') {
                	
                    alert('The test is no longer active.');
                    
                    // Redirect to user_dashboard
                    window.location.href = '<%=request.getContextPath()%>/user_dashboard';
                }
            }
        });
    }
window.addEventListener(
		"unload",
		function(event) {
			if (!formSubmitted) {
				alert("You have an unfinished test. Are you sure you want to leave?");
			}
		});				


function checkTestStatus() {
var tag = '<%=tag%>'; 
console.log(tag);
$.ajax({
	 // URL to your checkTestStatus endpoint
    url: "<%=request.getContextPath()%>/checkTestStatus?tag="+tag,
    success: function(data) {
    	
        if (data === 'inactive') {
        	
            alert('The test is no longer active.');
            
            // Redirect to user_dashboard
            window.location.href = '<%=request.getContextPath()%>/user_dashboard';
        }
    }
});
}
// Check the test status every second (1 second)
setInterval(checkTestStatus, 1000);

var myEvent = window.attachEvent || window.addEventListener;
var chkevent = window.attachEvent ? 'onbeforeunload' : 'beforeunload';

myEvent(chkevent, function (e) { // For >=IE7, Chrome, Firefox
    var confirmationMessage = 'Are you sure you want to leave?';

    if (window.confirm(confirmationMessage)) {
        // If the user confirms, redirect to the desired URL
        window.location.href = "<%=request.getContextPath()%>/user_dashboard";
    } else {
        // If the user cancels, prevent navigation
        e.returnValue = false;
    }
});



    </script>
</body>
</html>