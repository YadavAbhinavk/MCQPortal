<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="project.mcq.portal.entities.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="header.jsp"%>
    <style>.ques_containers
        {
            background-color:white;
            border-radius:10px;
            box-shadow: 2px 2px 10px 6px rgba(100,100,100,0.1);
            width:600px;
            overflow:hidden;
            margin:20px auto;
            padding: 20px;
            font-family:Arial, Helvetica, sans-serif;
            font-size: 25px;
        }
        .mybtn 
        {
            color: white;
            background-color:purple;
            width: 40%;
            margin:10px auto;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            text-transform: uppercase;
            font-weight: bold;
        }
        </style>
</head>
<body>
    <%
    String tag = (String) request.getAttribute("tag");
    String available = (String) request.getAttribute("isAvailable");
	List<Question> listOfQuestions = (List) request.getAttribute("listOfQuestions");
	int numOfQues = listOfQuestions.size();
    %>
    
   
    
    <div class="ques_containers">
        <h1>Instructions:</h1>
        <h4>Total number of questions:</h4><span><%= numOfQues %></span>
        <h4>Time allotted:</h4><span><%= 2*numOfQues %>minutes</span>
        <h4>Each question carries 1 mark; there are no negative marks.</h4>
        <h4>DO NOT refresh the page.</h4>
        <h3>All the Best!</h3>
    </div>
    <c:set var="tag" value="yourTagValue" />
    <c:set var="available" value="yourAvailableValue" />
    <c:set var="listOfQuestions" value="${listOfQuestions}" />
    
    <form action="<%= request.getContextPath()%>/start_test/<%= tag %>" method="post">
        <input type="hidden" name="tag" value="${tag}" />
        <input type="hidden" name="available" value="${available}" />
        <input type="hidden" name="listOfQuestions" value="${listOfQuestions}" />
        <input type="submit" value="Start Test" />
    </form>
   
</body>
</html>