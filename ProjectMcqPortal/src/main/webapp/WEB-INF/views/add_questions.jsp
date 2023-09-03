<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page import="project.mcq.portal.entities.*"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="header.jsp"%>
<link rel="stylesheet" href="<c:url value="/resources/css/css1.css" />">
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
		</div>
	</nav>

	<div class="start">
		<div class="quiz_header">
			<h1>Add ${tag} Question here</h1>
			<%
			String msg = (String) request.getAttribute("message");
			if (msg != null) {
				out.print(msg);
			}
			%>
		</div>
	</div>

	
	<div class="ques_container">
		<c:forEach var="i" begin="1" end="${numOfQues}">
			

				<form action="<%= request.getContextPath() %>/quesForm/${tag}"
					method="post" id="form${i}" class="ques_form" onsubmit="return checkform(this)">
					<div class="box1">
						<div>
							<label for="ques_name${i}">Question:</label>
						</div>
						<textarea name="ques_name" id=""  required></textarea>
					</div>
					<div class="box1">
						<div>
							<label for="option1${i}">Option1:</label>
						</div>
						<textarea name="option1" id="" required>

            </textarea >
					</div>
					<div class="box1">
						<div>
							<label for="option2${i}">Option2:</label>
						</div>
						<textarea name="option2" id="" required>

            </textarea >
					</div>
					<div class="box1">
						<div>
							<label for="option3${i}">Option3:</label>
						</div>
						<textarea name="option3" id="" required>

            </textarea>
					</div>
					<div class="box1">
						<div>
							<label for="option4${i}">Option4:</label>
						</div>
						<textarea name="option4" id="" required>

            </textarea>
					</div>
					<div class="box1">
						<div>
							<label for="answer${i}">Answer:</label>
						</div>

						<select name="answer" id="cars">
						    <option> Please select option</option>
							<option value="option1">Option1</option>
							<option value="option2">Option2</option>
							<option value="option3">Option3</option>
							<option value="option4">Option4</option>
						</select>

					</div>
					<input type="submit" value="Submit" class="mybtn">
				</form>
			

			<br>
			<br>
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
		</c:forEach>
	</div>
    
</body>
</html>