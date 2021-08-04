<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="ThemeBucket">
    <link rel="shortcut icon" href="#" type="image/png">

    <title>登陆</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <link href="${APP_PATH}/static/css/style.css" rel="stylesheet"  type="text/css">
    <!-- 响应式样式 -->
    <link href="${APP_PATH}/static/css/style-responsive.css" rel="stylesheet" type="text/css">

</head>

<body class="login-body">

<div class="container">
    <form class="form-signin" action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-signin-heading text-center">
            <h1 class="sign-title">登录</h1>

            <img src="images/login-logo.png" alt=""/>
        </div>

        <div class="login-wrap">
            <input type="text" class="form-control" placeholder="用户名" autofocus name="username">
            <input type="password" class="form-control" placeholder="密码" name="password">

            <input type="submit" value="登录" style="text-align: center;width: 290px">

            <div class="registration">
                <a class="" href="registration.html">${msg}</a>
            </div>
            <label class="checkbox">
                <input type="checkbox" value="remember-me"> 记住密码
                <span class="pull-right">
                    <a data-toggle="modal" href="#myModal"> 忘记密码?</a>

                </span>
            </label>

        </div>

        <!-- Modal -->
        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">忘记了密码 ?</h4>
                    </div>
                    <div class="modal-body">
                        <p>输入您的电子邮件地址重新设置您的密码.</p>
                        <input type="text" name="email" placeholder="邮箱" autocomplete="off" class="form-control placeholder-no-fix">

                    </div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-default" type="button">取消</button>
                        <button class="btn btn-primary" type="button">提交</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- modal -->

    </form>

</div>



<!-- Placed js at the end of the document so the pages load faster -->

<!-- Placed js at the end of the document so the pages load faster -->
<script src="${APP_PATH}/static/js/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${APP_PATH}/static/js/modernizr.min.js" type="text/javascript"></script>

</body>
</html>
