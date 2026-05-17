<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.library.pojo.User" %>
<%@ page import="com.library.pojo.Book" %>

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"管理员".equals(currentUser.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    Book book = (Book) request.getAttribute("book");
    if (book == null) {
        response.sendRedirect("bookList");
        return;
    }
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>修改图书</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-warning text-white">
                    <h4 class="mb-0">✏️ 修改图书信息</h4>
                </div>
                <div class="card-body">
                    <% if(request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>

                    <form action="editBook" method="post">
                        <input type="hidden" name="id" value="<%= book.getId() %>">
                        <div class="form-group">
                            <label for="title">书名</label>
                            <input type="text" class="form-control" id="title" name="title"
                                   value="<%= book.getTitle() %>" required>
                        </div>
                        <div class="form-group">
                            <label for="author">作者</label>
                            <input type="text" class="form-control" id="author" name="author"
                                   value="<%= book.getAuthor() %>" required>
                        </div>
                        <div class="form-group">
                            <label for="stock">库存数量</label>
                            <input type="number" class="form-control" id="stock" name="stock"
                                   value="<%= book.getStock() %>" min="0" required>
                        </div>
                        <button type="submit" class="btn btn-warning">更新</button>
                        <a href="bookList" class="btn btn-secondary">取消</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
