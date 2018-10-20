<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="pl.sdacademy.todo.dto.Task" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${param.lang}"/>
<fmt:setBundle basename="labels"/>
<fmt:setBundle basename="languages" var="languages"/>
<%--@elvariable id="task" type="pl.sdacademy.todo.dto.Task"--%>
<html>
<head>
    <title><fmt:message key="application.name"/></title>
    <link rel="stylesheet" href="webjars/bootstrap/4.1.3/css/bootstrap.min.css" type="text/css">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="small text-right">
                <a href="index.jsp?lang=pl_PL"><fmt:message key="language.polish" bundle="${languages}"/></a> |
                <a href="index.jsp?lang=en_GB"><fmt:message key="language.english" bundle="${languages}"/></a> |
                <a href="index.jsp?lang=de_DE"><fmt:message key="language.german" bundle="${languages}"/></a>
            </div>
            <div class="text-center">
                <h1 class="display-3"><fmt:message key="application.name"/></h1>
                <form action="index.jsp" method="POST">
                    <div class="form-row align-items-center">
                        <div class="col-md-10">
                            <input type="text" id="newTask" name="newTask" class="form-control" autocomplete="off"/>
                        </div>
                        <div class="col-md-2">
                            <input type="submit" class="btn btn-outline-primary btn-sm"
                                   value="<fmt:message key="task.new"/>"/>
                        </div>
                    </div>
                </form>
            </div>
            <%
                List<Task> tasks = (List<Task>) session.getAttribute("tasks");
                if (tasks == null) {
                    tasks = new ArrayList<>();
                    session.setAttribute("tasks", tasks);
                }
            %>
            <c:if test="${!empty param.newTask && tasks.add(Task.create(param.newTask))}">
                <c:redirect url="index.jsp"/>
            </c:if>
            <c:if test="${!empty param.id}">
                <% tasks.remove(Integer.parseInt(request.getParameter("id"))); %>
                <c:redirect url="index.jsp"/>
            </c:if>
            <div class="card shadow-sm p-3 mb-5 bg-white rounded">
                <ul class="list-group list-group-flush">
                    <c:forEach var="task" items="${sessionScope['tasks']}">
                        <c:url var="deleteUrl" value="index.jsp">
                            <c:param name="id" value="${tasks.indexOf(task)}"/>
                        </c:url>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                ${task.description}
                            <span class="close">
                                <a href="${deleteUrl}" aria-label="<fmt:message key="task.delete"/>">
                                    <span aria-hidden="true">&times;</span>
                                </a>
                            </span>
                        </li>
                    </c:forEach>
                </ul>
                <c:if test="${tasks.isEmpty()}">
                    <div class="text-center"><fmt:message key="task.empty"/></div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script src="webjars/jquery/3.3.1-1/jquery.min.js"></script>
<script src="webjars/popper.js/1.14.4/popper.min.js"></script>
<script src="webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>
