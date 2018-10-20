<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="pl.sdacademy.todo.dto.Task" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Todo app</title>
    <link rel="stylesheet" href="webjars/bootstrap/4.1.3/css/bootstrap.min.css" type="text/css">
</head>
<body>

<%
    List<Task> tasks = (List<Task>) session.getAttribute("tasks");
    if (tasks == null) {
        tasks = new ArrayList<>();
        session.setAttribute("tasks", tasks);
    }
%>

<form action="index.jsp" method="POST">
    <label for="newTask">Zadanie</label>
    <input type="text" id="newTask" name="newTask"/><br/>
    <input type="submit" value="Dodaj"/>
</form>
<br>

<ol>
    <c:if test="${!empty param.newTask && tasks.add(Task.create(param.newTask))}">
        <c:redirect url="index.jsp"/>
    </c:if>

    <c:if test="${!empty param.id}">
        <%
            int id = Integer.valueOf(request.getParameter("id"));
            tasks.remove(id);
        %>
        <c:redirect url="index.jsp"/>

    </c:if>

    <%--@elvariable id="task" type="pl.sdacademy.todo.dto.Task"--%>
    <c:forEach var="task" items="${sessionScope['tasks']}">

        <c:url var="deleteUrl" value="index.jsp">
            <c:param name="id" value="${tasks.indexOf(task)}"/>
        </c:url>

        <li>${task.description} <a href="${deleteUrl}">Usuń</a></li>
    </c:forEach>
</ol>
<c:if test="${tasks.isEmpty()}">
    Brak zadań do wykonania
</c:if>
<script src="webjars/jquery/3.3.1-1/jquery.min.js"></script>
<script src="webjars/popper.js/1.14.4/popper.min.js"></script>
<script src="webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>
