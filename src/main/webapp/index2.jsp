<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:forward page="/emps"></jsp:forward>
<html>
<head>
    <title>Title</title>

    <%--引入BootStrap--%>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">

    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <%--引入jQuery--%>
    <script type="text/javascript" src="static/js/jquery-3.2.1.min.js"></script>
</head>
<body>


<%--<button  class="btn btn-success">按钮</button>--%>
<%--<%
/*
    response.sendRedirect(request.getContextPath()+"/WEB-INF/views/list.jsp");
*/
    //jsp文件放在WEB-INF目录下只能通过请求转发的形式进行访问
    request.getRequestDispatcher(request.getContextPath()+"/WEB-INF/views/list.jsp").forward(request,response);
%>--%>
</body>
</html>
