<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="project.mcq.portal.entities.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="header.jsp"%>
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

		<ul class="nav-links" id="navLinks">
			<li><a href="<%=request.getContextPath()%>/user_dashboard">View Dashboard</a></li>
		</ul>

	</nav>

	<div class="table">
		<div class="table_header">
			<p>User Dashboard</p>

		</div>
		<div class="table_section">
			<table>
				<thead>
					<tr>
						<th>S.No</th>
						<th>Tag</th>
						<th>Submission Time</th>
						<th>Score</th>


					</tr>
				</thead>
				<%
				List<UserTest> userListOfTests = (List) request.getAttribute("userListOfTests");
				String message = (String) request.getAttribute("messagee");
				if (userListOfTests != null) {

					int index = 0;
					for (UserTest userTest : userListOfTests) {
						index++;
				%>
				<tr>
					<td><%=index%></td>
					<td><%=userTest.getTag()%></td>
					<td><%=userTest.getSubmissionTime()%></td>
					<td><%=userTest.getScore()%></td>


				</tr>
				<%
				}
				}
				%>
			</table>
		</div>
	</div>
	<div>
	</div>


</body>
</html>