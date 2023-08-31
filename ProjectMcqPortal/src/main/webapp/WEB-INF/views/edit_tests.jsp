<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="project.mcq.portal.entities.*"%>
<%@page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	String tag = (String) request.getAttribute("tag");
	List<Question> listOfQuestions = (List) request.getAttribute("listOfQuestions");
	String message = (String) request.getAttribute("message");
	String isAvailable = (String) request.getAttribute("isAvailable");
	if (isAvailable != null) {
	%>
	<div class="table">

		<div class="table_header">
			<p><%=tag%>
				Test
			</p>
			<div style="display: flex;">
				<form action="<%=request.getContextPath()%>/add_question/<%=tag%>"
					method="get">
					<input type="number" name="numOfQues" min=0 max=50 value="0"
						required /> <input type="submit" class="add_new"
						value="Add questions" style="color: white;" />
				</form>

				<form action="<%=request.getContextPath()%>/option/<%=tag%>"
					method="get">
					<select name="isAvailable">
						<option value="active"
							<%if (isAvailable.equalsIgnoreCase("active")) {
	out.print("selected");
}%>>Active</option>
						<option value="inactive"
							<%if (isAvailable.equalsIgnoreCase("inactive")) {
	out.print("selected");
}%>>Inactive</option>
					</select>
					<%
					}
					%>
					<input type="submit" class="add_new" value="Submit"
						style="color: white;" />
				</form>
			</div>
		</div>

		<div class="table_section">
			<table>
				<thead>
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
				if (listOfQuestions != null) {
					int index = 0;
					for (Question ques : listOfQuestions) {
						index++;
				%>
				<tr>
					<td><%=index%></td>

					<td><%=ques.getQuestionName()%></td>
					<td><%=ques.getOption1()%></td>
					<td><%=ques.getOption2()%></td>
					<td><%=ques.getOption3()%></td>
					<td><%=ques.getOption4()%></td>
					<td><%=ques.getCorrectAnswer()%></td>
					<td>
						<button style="color: white;">
							<a
								href="<%=application.getContextPath()%>/update_ques/<%=ques.getQuestionId()%>"><i
								class="fa-solid fa-pen-to-square"></i></a>
						</button>
						<button>
							<a
								href="<%=application.getContextPath()%>/delete_ques/<%=ques.getQuestionId()%>/<%=ques.getTag()%>"><i
								class="fa-solid fa-trash"></i></a>
						</button>
					</td>
				</tr>
				<%
				}
				}
				%>
			</table>
		</div>
		<br>
		<br>
	</div>



</body>
</html>