<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>图书管理系统 - 用户登录</title>
    <!-- 引入在线 Bootstrap 样式，国内 CDN 加速，访问非常流畅 -->
    <link href="https://lf3-cdn-tos.bytecdntp.com/cdn/expire-1-M/bootstrap/4.6.1/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f5f7fa; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .login-card { width: 400px; border: none; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .card-header { background: #007bff; color: white; text-align: center; font-weight: bold; border-radius: 10px 10px 0 0 !important; }
    </style>
</head>
<body>

<div class="card login-card">
    <div class="card-header py-3">
        <h4 class="m-0">📚 图书管理系统</h4>
    </div>
    <div class="card-body p-4">

        <!-- ⚠️ 错误信息提示：如果后端传来错误，这里会自动显示 -->
        <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-danger text-center py-2" role="alert">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <!-- 登录表单，action="login" 对应我们写的 LoginServlet -->
        <form action="login" method="post">
            <div class="form-group">
                <label for="username">账号</label>
                <input type="text" class="form-control" id="username" name="username" placeholder="请输入账号" required>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block mt-4">立即登录</button>
        </form>

    </div>
</div>

</body>
</html>
