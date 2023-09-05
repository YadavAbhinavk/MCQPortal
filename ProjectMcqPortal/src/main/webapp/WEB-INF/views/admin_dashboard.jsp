<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="project.mcq.portal.entities.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="header.jsp"%>
<style>

</style>
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

		<ul class="nav-links" id="navLinks">
			<li><a href="<%=request.getContextPath()%>/logout">Logout</a></li>
		</ul>

	</nav>

	<div class="table">
		<div class="table_header">
			<p>Admin Dashboard</p>
			<div>
			
			<span id="message">
			<%String msg = (String)request.getAttribute("message");if (msg != null) { %>
		    <%= msg %>
		  <% } %>
		  </span>
				<a href="<%=request.getContextPath()%>/add_test"><button
						class="add_new">+Add New Test</button></a>
			</div>
		</div>
		<div class="table_section">
			<table>
				<thead>
					<tr>
						<th>S.No</th>
						<th>Test Name</th>
						<th>Total Questions</th>
						<th>Users appeared</th>
						<th>Status</th>
						<th>Action</th>

					</tr>
				</thead>
				<%

						List<Tests> listOfTests = (List<Tests>)request.getAttribute("listOfTests");
						// Number of questions per page
					    int testsPerPage = 8;

					    // Calculate the total number of pages
					    int totalPages = (listOfTests.size() + testsPerPage - 1) / testsPerPage;

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
					    int startIndex = (currentPage - 1) * testsPerPage;
					    int endIndex = Math.min(startIndex + testsPerPage,  listOfTests.size());
					    		
						if (listOfTests != null) {
							int index = startIndex + 1; // Start index for the current page
				                    for (int i = startIndex; i < endIndex; i++) {
				                        Tests test = listOfTests.get(i);
				%>
				<tr>
					<td><%=index++%></td>
					<td><%=test.getTag()%></td>
					<td><%=test.getNumberOfQuestions()%></td>
					<td><%=test.getNumberOfUsers()%></td>
					<td><%=test.getIsAvailable()%></td>
					<td>
						
							<a href="<%=application.getContextPath()%>/update_tests/<%=test.getTag()%>" id="edit_icon">
							<i class="fa-solid fa-pen-to-square" ></i>
							</a>
							<a href="javascript:void(0);" onclick="confirmDelete('<%= test.getTag() %>','<%= test.getIsAvailable() %>')"><i
								class="fa-solid fa-trash"></i></a>

					</td>
				</tr>
				<%
				}
				}
				%>
			</table>
		</div>
	</div>
<br><br>
<!-- Pagination controls -->
<div class="center">
<div class="pagination">
        <a href="<%= request.getContextPath() %>/admin_dashboard/?p=1">&laquo;</a>
        <%
            for(int p = 1; p <= totalPages; p++) {
        %>
        <a href="<%= request.getContextPath() %>/admin_dashboard/?p=<%= p %>"
               <%= (p == currentPage) ? "class='active'" : "" %>><%= p %></a>
        <%
            }
        %>
        <a href="<%= request.getContextPath() %>/admin_dashboard/?p=<%= totalPages %>">&raquo;</a>
</div>
</div>
<script>
function confirmDelete(tag, isAvailable) {
    if (isAvailable === "active") {
        var confirmDeactivate = confirm("The test is currently active. Are you sure you want to delete it? Please deactivate it first.");
        if (confirmDeactivate) {
            // Redirect to a deactivate endpoint or handle deactivation logic here
            window.location.href = "<%= request.getContextPath() %>/update_tests/"+tag;
        }
    } else {
        var confirmDelete = confirm("Are you sure you want to delete the whole Test?");
        if (confirmDelete) {
            window.location.href = "<%= request.getContextPath() %>/delete_test/"+tag;
        }
    }
}
</script>

    <script src="<c:url value='/resources/js/index.js'/>"></script>
</body>
</html>