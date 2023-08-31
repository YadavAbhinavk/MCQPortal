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
			<li><a href="<%=request.getContextPath()%>/logout">Logout</a></li>
		</ul>

	</nav>

	<div class="table">
		<div class="table_header">
			<p>Admin Dashboard</p>
			<div>
				<a href="<%=request.getContextPath()%>/add_test"><button
						class="add_new">+Add New Test</button></a>
			</div>
		</div>
		<div class="table_section">
			<table>
				<thead>
					<tr>
						<th>S.No</th>
						<th>Tag</th>
						<th>Total Questions</th>
						<th>Users appeared</th>
						<th>Status</th>
						<th>Action</th>

					</tr>
				</thead>
				<%
				List<Test> listOfTests = (List) request.getAttribute("listOfTests");
				String message = (String) request.getAttribute("messagee");
				if (listOfTests != null) {

					int index = 0;
					for (Test test : listOfTests) {
						index++;
				%>
				<tr>
					<td><%=index%></td>
					<td><%=test.getTag()%></td>
					<td><%=test.getNumberOfQuestions()%></td>
					<td><%=test.getNumberOfUsers()%></td>
					<td><%=test.getIsAvailable()%></td>
					<td>
						<button style="color: white;">
							<a
								href="<%=application.getContextPath()%>/update_tests/<%=test.getTag()%>"><i
								class="fa-solid fa-pen-to-square"></i></a>
						</button>
						<button>
							<a
								href="<%=application.getContextPath()%>/delete_test/<%=test.getTag()%>"><i
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
	</div>


</body>
</html>