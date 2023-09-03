<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="project.mcq.portal.entities.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="header.jsp"%>
<style>
a
{
text-decoration:none;
color:black;
transition:0.7s;
}
a:hover 
{
color:red;
transition:0.3s;
}
</style>
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

		<ul class="nav-links" id="navLinks">
			<li><a href="<%=request.getContextPath()%>/logout">Logout</a></li>
		</ul>

	</nav>
	
<div class="table">
		<div class="table_header">
			<p>User Dashboard</p>
			<div>
			<span id="message">
			<%String msg = (String)request.getAttribute("message");if (msg != null) { %>
		    <%= msg %>
		  <% } %>
		  </span>
                <a href="<%= application.getContextPath() %>/user_test"><button class="add_new">View Past Tests</button></a>
            </div>
		</div>
		
<div class="table_section">
<table>
<tr>
        <th>Test No.</th>
        <th>Tag</th>
        <th>No of questions</th>
        <th>Action</th>
    </tr>
 
    <% 
    List<Test> listOfTests = (List)request.getAttribute("listOfTests");
    int testsPerPage = 10; // Number of tests per page
    int totalPages = (listOfTests.size() + testsPerPage - 1) / testsPerPage;
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
 
    int startIndex = (currentPage - 1) * testsPerPage;
    int endIndex = Math.min(startIndex + testsPerPage, listOfTests.size());

    if (listOfTests != null) {
        int index =  startIndex + 1;
        for (int i = startIndex; i < endIndex; i++) {
            Test test = listOfTests.get(i);
            if (test.getIsAvailable().equals("active")) {
    %>
     <tr>
     <td><%= index++ %></td>
     <td><%= test.getTag() %></td>
     <td><%= test.getNumberOfQuestions() %></td>
     
     <td>
     <a href="<%= application.getContextPath() %>/start_test/<%= test.getTag() %>">Start Test</a>
     </td>
     
     </tr>
     <%}} }%>
</table>
</div>
</div>
 <br><br>
 <!-- Pagination controls -->
<div class="center">
<div class="pagination">
        <a href="<%= request.getContextPath() %>/user_dashboard/?p=1">&laquo;</a>
        <%
            for(int p = 1; p <= totalPages; p++) {
        %>
        <a href="<%= request.getContextPath() %>/user_dashboard/?p=<%= p %>"
               <%= (p == currentPage) ? "class='active'" : "" %>><%= p %></a>
        <%
            }
        %>
        <a href="<%= request.getContextPath() %>/user_dashboard/?p=<%= totalPages %>">&raquo;</a>
</div>
</div>
</body>
</html>