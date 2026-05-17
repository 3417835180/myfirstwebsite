<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.library.pojo.User" %>

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"管理员".equals(currentUser.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>添加图书</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-success text-white">
                    <h4 class="mb-0">📚 添加新图书</h4>
                </div>
                <div class="card-body">
                    <% if(request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>

                    <form action="addBook" method="post">
                        <div class="form-group">
                            <label for="title">书名</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        <div class="form-group">
                            <label for="author">作者</label>
                            <input type="text" class="form-control" id="author" name="author" required>
                        </div>
                        <div class="form-group">
                            <label for="stock">库存数量</label>
                            <input type="number" class="form-control" id="stock" name="stock" min="0" required>
                        </div>
                        <button type="submit" class="btn btn-success">保存</button>
                        <a href="bookList" class="btn btn-secondary">取消</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
