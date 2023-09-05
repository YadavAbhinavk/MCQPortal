<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="project.mcq.portal.entities.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="header.jsp"%>
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
		<span id="message"> <%
 String msg = (String) request.getAttribute("message");
 if (msg != null) {
 %>
			<%=msg%> <%
 }
 %>
		</span>
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
	String tag = (String) request.getAttribute("tag");
	List<Question> listOfQuestions = (List<Question>) request.getAttribute("listOfQuestions");
	Tests test = (Tests) request.getAttribute("test");

	// Number of questions per page
	int questionsPerPage = 10;

	// Calculate the total number of pages
	int totalPages = (listOfQuestions.size() + questionsPerPage - 1) / questionsPerPage;

	// Get the current page parameter
	String currentPageParam = request.getParameter("p");
	int currentPage = (currentPageParam != null) ? Integer.parseInt(currentPageParam) : 1;
	// Check if currentPageParam is a valid integer
	if (currentPageParam != null) {
		try {
			currentPage = Integer.parseInt(currentPageParam);
			// Ensure that currentPage is within valid bounds
			currentPage = Math.min(Math.max(currentPage, 1), totalPages);
		} catch (NumberFormatException e) {
			// Handle invalid page number gracefully
			currentPage = 1; // Redirect to the first page
		}
	}
	// Calculate the start and end indices for the current page
	int startIndex = (currentPage - 1) * questionsPerPage;
	int endIndex = Math.min(startIndex + questionsPerPage, listOfQuestions.size());
	if (test.getIsAvailable() != null) {
	%>
	<br>
	<br>

	<div class="table">
		<form action="<%=request.getContextPath()%>/add_question/<%=tag%>"
			method="get">
			<div style="margin:15px;">
				<input type="number" name="numOfQues" min="1" max="50" value="1"
					required /> <input type="submit" class="add_new"
					value="Add questions" style="color: white;" />
			</div>
		</form>
		<div class="table_header"
			style="height: 100px; display: flex; flex-direction: row;">
			<p><%=tag%>
				Test
			</p>

			<div>
				<div style="margin-left:75%;">
					<form action="<%=request.getContextPath()%>/option/<%=tag%>"
						method="get" style="display: flex; align-items: center;">
						<select name="isAvailable" style="margin-right: 10px;">
							<option value="active"
								<%=(test.getIsAvailable() != "" && test.getIsAvailable().equalsIgnoreCase("active")) ? "selected" : ""%>>Active</option>
							<option value="inactive"
								<%=(test.getIsAvailable() != "" && test.getIsAvailable().equalsIgnoreCase("inactive")) ? "selected" : ""%>>Inactive</option>
						</select> <input type="submit" class="add_new" value="Change"
							style="color: white;" />
					</form>

				</div>
				<br>
				<div style="margin-bottom:100px;">
					<form action="<%=request.getContextPath()%>/option1/<%=tag%>"
						method="get"
						onsubmit="return checkAvailable('<%=test.getIsAvailable()%>');">
						<input type="number" name="quesPerTest" min="1"
							max="<%=test.getNumberOfQuestions()%>"
							value="<%=test.getQuestionsPerTest()%>" style="width: 100px;" />
						<label>Questions Per Test</label> <input type="number"
							name="timePerQues" min="5" max="1200"
							value="<%=test.getTimePerQuestion()%>" style="width: 100px;" />
						<label>Time per each questions in(seconds)</label> <input
							type="submit" class="add_new" value="Change"
							style="color: white; float: right;" />
					</form>
				</div>

			</div>
		</div>

		<div class="table_section">
			<table>
				<thead>
					<%
					if (listOfQuestions != null) {
					%>
					<tr>
						<th>S.No</th>
						<th>Question Name</th>
						<th>Option1</th>
						<th>Option2</th>
						<th>Option3</th>
						<th>Option4</th>
						<th>Answer</th>
						<th>Action</th>

					</tr>
				</thead>
				<%
				int index = startIndex + 1; // Start index for the current page
				for (int i = startIndex; i < endIndex; i++) {
					Question ques = listOfQuestions.get(i);
				%>
				<tr>
					<td><%=index++%></td>
					<td><c:out value="<%=ques.getQuestionName()%>"
							escapeXml="true" /></td>
					<td><%=ques.getOption1()%></td>
					<td><%=ques.getOption2()%></td>
					<td><%=ques.getOption3()%></td>
					<td><%=ques.getOption4()%></td>
					<td><%=ques.getCorrectAnswer()%></td>
					<td><a href="javascript:void(0);"
						onclick="confirmAndUpdate('<%=ques.getQuestionId()%>','<%=ques.getTag()%>','<%=test.getIsAvailable()%>')"
						id="edit_icon"><i class="fa-solid fa-pen-to-square"></i></a> <a
						href="javascript:void(0);"
						onclick="confirmDelete('<%=ques.getQuestionId()%>','<%=ques.getTag()%>','<%=test.getIsAvailable()%>')"
						id="delete_icon"><i class="fa-solid fa-trash"></i></a></td>
				</tr>
				<%
				}
				}
				}
				%>

			</table>
		</div>
		<br> <br>
	</div>
	<br>
	<br>

	<!-- Pagination controls -->
	<div class="center">
		<div class="pagination">
			<a href="<%=request.getContextPath()%>/update_tests/<%=tag%>?p=1">&laquo;</a>
			<%
			for (int p = 1; p <= totalPages; p++) {
			%>
			<a
				href="<%=request.getContextPath()%>/update_tests/<%=tag%>?p=<%=p%>"
				<%=(p == currentPage) ? "class='active'" : ""%>><%=p%></a>
			<%
			}
			%>
			<a
				href="<%=request.getContextPath()%>/update_tests/<%=tag%>?p=<%=totalPages%>">&raquo;</a>
		</div>

	</div>


	<script>
function checkAvailable(isAvailable) {
    if (isAvailable === "active") {
        // Show a confirmation dialog
        if (confirm("The test is currently active. Do you want to make it Inactive and then update it?")) {
            window.location.href = "<%=request.getContextPath()%>/update_tests/<%=tag%>";
            return false; // Prevent form submission
        } else {
           
            return true; // Proceed with form submission
        }
    } else {
        
        return true; // Proceed with form submission
    }
}
function confirmDelete(questionId, tag, isAvailable) {
    if (isAvailable === "active") {
        if (confirm("The test is currently active. Please make it Inactive and delete the question. " + tag)) 
        {
            window.location.href = "<%=request.getContextPath()%>/update_tests/" + tag;
        }
    } else {
        window.location.href = "<%=request.getContextPath()%>/delete_ques/" + questionId + '/' + tag;
    }
}
function confirmAndUpdate(questionId,tag,isAvailable) {
	if (isAvailable === "active") {
        if (confirm("The test is currently active. Please make it Inactive and update the question. " + tag)) 
        {
            window.location.href = "<%=request.getContextPath()%>/update_tests/" + tag;
        }
    } 
	else
		{

        window.location.href = "<%=request.getContextPath()%>/update_ques/"+ questionId;
			}
		}
	</script>

</body>
</html>