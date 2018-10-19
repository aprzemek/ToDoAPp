<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="pl.sdacademy.todo.dto.Task" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<%
    String newTask = request.getParameter("newTask");
    if (newTask != null && !newTask.isEmpty()) {
        Task task = new Task();
        task.setDescription(newTask);
        tasks.add(task);
    }
%>

<br>
<ol>
    <%
        for (Task s : tasks) {
            out.println("<li>" + s.getDescription() + "</li>");
        }
    %>
</ol>
<%
    if (tasks.isEmpty()) {
        out.println("Brak zadań do wykonania");
    }
%>
<script src="webjars/jquery/3.3.1-1/jquery.min.js"></script>
<script src="webjars/popper.js/1.14.4/popper.min.js"></script>
<script src="webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>
