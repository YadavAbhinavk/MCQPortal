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
	List<Question> listOfQuestions = (List<Question>)request.getAttribute("listOfQuestions");
	String message = (String) request.getAttribute("message");
	String isAvailable = (String) request.getAttribute("isAvailable");
	
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
	if (isAvailable != null) {
	%>
	<div class="table">

		<div class="table_header">
			<p><%=tag%>
				Test
			</p>
			<span id="message">
			<%String msg = (String)request.getAttribute("message");if (msg != null) { %>
		    <%= msg %>
		    
		  <% } %>
		  </span>
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
				<%if (listOfQuestions != null) { %>
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
					<td><c:out value="<%= ques.getQuestionName() %>" escapeXml="true" /></td>
					<td><%=ques.getOption1()%></td>
					<td><%=ques.getOption2()%></td>
					<td><%=ques.getOption3()%></td>
					<td><%=ques.getOption4()%></td>
					<td><%=ques.getCorrectAnswer()%></td>
					<td>

							<a
								href="<%=application.getContextPath()%>/update_ques/<%=ques.getQuestionId()%>" id="edit_icon"><i
								class="fa-solid fa-pen-to-square"></i></a>
							<a
								href="<%=application.getContextPath()%>/delete_ques/<%=ques.getQuestionId()%>/<%=ques.getTag()%>"id="delete_icon"><i
								class="fa-solid fa-trash"></i></a>
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
<br><br>
<!-- Pagination controls -->
<div class="center">
<div class="pagination">
        <a href="<%= request.getContextPath() %>/update_tests/<%= tag %>?p=1">&laquo;</a>
        <%
            for(int p = 1; p <= totalPages; p++) {
        %>
        <a href="<%= request.getContextPath() %>/update_tests/<%= tag %>?p=<%= p %>"
               <%= (p == currentPage) ? "class='active'" : "" %>><%= p %></a>
        <%
            }
        %>
        <a href="<%= request.getContextPath() %>/update_tests/<%= tag %>?p=<%= totalPages %>">&raquo;</a>
</div>
</div>

<script src="<c:url value="/resources/js/script.js"/>"></script>
</body>
</html>