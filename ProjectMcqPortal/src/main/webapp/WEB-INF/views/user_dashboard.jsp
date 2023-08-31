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
                <a href="#"><button class="add_new">View Past Tests</button></a>
            </div>
		</div>
<div class="table_section">
<table>
<tr>
        <th>S.No</th>
        <th>Tag</th>
        <th>No of questions</th>
        <th>Action</th>
    </tr>
 
 
    <% 
    List<Test> listOfTests = (List)request.getAttribute("listOfTests");
    String message = (String)request.getAttribute("messagee");
    if(listOfTests != null)
    {
 
    int index = 0;
    for(Test test:listOfTests)
    {
 
    	if(test.getIsAvailable().equals("active"))
    	{
    	index++;
    %>
     <tr>
     <td><%= index %></td>
     <td><%= test.getTag() %></td>
     <td><%= test.getNumberOfQuestions() %></td>
     <td>
     <a href="<%= application.getContextPath() %>/start_test/<%= test.getTag() %>"> Start Test</a>
     </td>
 
     </tr>
     <%}} }%>
</table>
</div>
</div>
 
</body>
</html>