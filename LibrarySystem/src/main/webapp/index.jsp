<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.library.pojo.User" %>
<%@ page import="com.library.pojo.Book" %>
<%@ page import="java.util.List" %>

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Book> books = (List<Book>) request.getAttribute("books");
    if (books == null) {
        response.sendRedirect("bookList");
        return;
    }
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>图书管理系统 - 首页</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f5f7fa; }
        .navbar-brand { font-weight: bold; }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="bookList">📚 图书管理后台</a>
        <div class="navbar-text text-white ml-auto">
            欢迎你，<strong><%= currentUser.getUsername() %></strong>
            <span class="badge badge-info ml-2"><%= currentUser.getRole() %></span>
            <a href="login.jsp" class="btn btn-sm btn-outline-light ml-3">退出登录</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>📖 馆藏图书列表</h2>

        <c:if test="${sessionScope.user.role == '管理员'}">
            <a href="addBook" class="btn btn-success">+ 添加新图书</a>
        </c:if>
    </div>

    <% if(session.getAttribute("success") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= session.getAttribute("success") %>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <% session.removeAttribute("success"); %>
    <% } %>

    <% if(session.getAttribute("error") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= session.getAttribute("error") %>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <% session.removeAttribute("error"); %>
    <% } %>

    <table class="table table-bordered table-hover bg-white shadow-sm">
        <thead class="thead-light">
            <tr>
                <th>图书编号</th>
                <th>书名</th>
                <th>作者</th>
                <th>库存数量</th>
                <th>操作选项</th>
            </tr>
        </thead>
        <tbody>
            <% if(books.isEmpty()) { %>
                <tr>
                    <td colspan="5" class="text-center text-muted py-4">暂无图书数据</td>
                </tr>
            <% } else {
                for(Book book : books) { %>
                <tr>
                    <td><%= book.getId() %></td>
                    <td><%= book.getTitle() %></td>
                    <td><%= book.getAuthor() %></td>
                    <td>
                        <span class="badge <%= book.getStock() > 0 ? "badge-success" : "badge-danger" %>">
                            <%= book.getStock() %>
                        </span>
                    </td>
                    <td>
                        <c:if test="${sessionScope.user.role == '普通用户'}">
                            <form action="borrowBook" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="<%= book.getId() %>">
                                <button type="submit" class="btn btn-sm btn-primary"
                                        <%= book.getStock() <= 0 ? "disabled" : "" %>>
                                    点击借阅
                                </button>
                            </form>
                        </c:if>
                        <c:if test="${sessionScope.user.role == '管理员'}">
                            <a href="editBook?id=<%= book.getId() %>" class="btn btn-sm btn-warning mr-2">修改</a>
                            <form action="deleteBook" method="post" style="display:inline;"
                                  onsubmit="return confirm('确定要删除《<%= book.getTitle() %>》吗？')">
                                <input type="hidden" name="id" value="<%= book.getId() %>">
                                <button type="submit" class="btn btn-sm btn-danger">删除</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            <% } } %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
