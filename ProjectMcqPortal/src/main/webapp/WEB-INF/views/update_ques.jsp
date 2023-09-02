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
		response.sendRedirect("home");
	}
	%>

	<nav class="navbar">
		<div class="logo">
			<img src="<c:url value = "/resources/images/home/quiz_icon.png"/> ">
			Quiz<span>Vault</span>
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
	out.print(ques);
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
					<textarea name="ques_name" id="" cols="50" rows="7">
                         <%=ques.getQuestionName()%>
            </textarea>
				</div>

				<div class="box1">
					<div>
						<label for="option1">Option 1:</label>
					</div>
					<input type="text" name="option1" value="<%=ques.getOption1()%>" required>
				</div>

				<div class="box1">
					<div>
						<label for="option2">Option 2:</label>
					</div>
					<input type="text" name="option2" value="<%=ques.getOption2()%>" required>
				</div>

				<div class="box1">
					<div>
						<label for="option3">Option 3:</label>
					</div>
					<input type="text" name="option3" value="<%=ques.getOption3()%>" required>
				</div>

				<div class="box1">
					<div>
						<label for="option4">Option 4:</label>
					</div>
					<input type="text" name="option4" value="<%=ques.getOption4()%>" required>
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
	<p>
		<%
		String msg = (String) request.getAttribute("message");
		if (msg != null) {
			out.print(msg);
		}
		%>
	</p>
<script>
            document.querySelector("#form${i}").addEventListener("submit", function(event) {
                event.preventDefault();
                const form = this;
                const formData = new FormData(form);
 
                fetch(form.action, {
                    method: "POST",
                    body: formData
                })
                .then(response => response.text())
                .then(data => {
                    
                    form.style.display = "none";
                    
                })
                .catch(error => console.error("Error:", error));
            });
            
            
            function checkform(form) {
                // get all the inputs within the submitted form
                var inputs = form.getElementsByTagName('input' || 'textarea');
                for (var i = 0; i < inputs.length; i++) {
                    // only validate the inputs that have the required attribute
                    if(inputs[i].hasAttribute("required")){
                        if(inputs[i].value == ""){
                            // found an empty field that is required
                            alert("Please fill all required fields");
                            return false;
                        }
                    }
                }
                return true;
            }
        </script>

</body>
</html>