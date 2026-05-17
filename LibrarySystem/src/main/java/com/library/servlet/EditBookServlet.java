package com.library.servlet;

import com.library.dao.BookDao;
import com.library.pojo.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editBook")
public class EditBookServlet extends HttpServlet {

    private BookDao bookDao = new BookDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            int id = Integer.parseInt(idStr);
            Book book = bookDao.findById(id);
            
            if (book != null) {
                request.setAttribute("book", book);
                request.getRequestDispatcher("editBook.jsp").forward(request, response);
            } else {
                response.sendRedirect("bookList");
            }
        } else {
            response.sendRedirect("bookList");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String idStr = request.getParameter("id");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String stockStr = request.getParameter("stock");
        
        if (idStr != null && !idStr.trim().isEmpty() &&
            title != null && !title.trim().isEmpty() && 
            author != null && !author.trim().isEmpty() &&
            stockStr != null && !stockStr.trim().isEmpty()) {
            
            Book book = new Book();
            book.setId(Integer.parseInt(idStr));
            book.setTitle(title);
            book.setAuthor(author);
            book.setStock(Integer.parseInt(stockStr));
            
            boolean success = bookDao.update(book);
            
            if (success) {
                response.sendRedirect("bookList");
            } else {
                request.setAttribute("error", "修改图书失败");
                request.setAttribute("book", book);
                request.getRequestDispatcher("editBook.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "请填写完整信息");
            if (idStr != null) {
                Book book = bookDao.findById(Integer.parseInt(idStr));
                request.setAttribute("book", book);
            }
            request.getRequestDispatcher("editBook.jsp").forward(request, response);
        }
    }
}
