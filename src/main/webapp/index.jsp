<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="pl.sdacademy.todo.dto.Task" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${param.lang}"/>
<fmt:setBundle basename="labels"/>

<html>
<head>
    <title><fmt:message key="application.name"/></title>
    <link rel="stylesheet" href="webjars/bootstrap/4.1.3/css/bootstrap.min.css" type="text/css">
</head>
<body>
<div class="container">
    <fmt:setBundle basename="languages"/>

    <div class="float-right">
        <a href="index.jsp?lang=pl_PL"><fmt:message key="language.polish"/></a> |
        <a href="index.jsp?lang=en_GB"><fmt:message key="language.english"/></a> |
        <a href="index.jsp?lang=de_DE"><fmt:message key="language.german"/></a>
    </div>

    <fmt:setBundle basename="labels"/>

    <h1 class="display-3"><fmt:message key="application.name"/></h1>

    <%
        List<Task> tasks = (List<Task>) session.getAttribute("tasks");
        if (tasks == null) {
            tasks = new ArrayList<>();
            session.setAttribute("tasks", tasks);
        }
    %>

    <form action="index.jsp" method="POST">
        <input type="text" id="newTask" name="newTask"/><br/>
        <input type="submit" value="<fmt:message key="task.new"/>"/>
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

            <li>${task.description} <a href="${deleteUrl}"><fmt:message key="task.delete"/></a></li>
        </c:forEach>
    </ol>
    <c:if test="${tasks.isEmpty()}">
        <fmt:message key="task.empty"/>
    </c:if>
</div>
<script src="webjars/jquery/3.3.1-1/jquery.min.js"></script>
<script src="webjars/popper.js/1.14.4/popper.min.js"></script>
<script src="webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>
