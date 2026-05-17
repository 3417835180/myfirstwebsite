package com.library.servlet;

import com.library.dao.BookDao;
import com.library.pojo.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addBook")
public class AddBookServlet extends HttpServlet {

    private BookDao bookDao = new BookDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String stockStr = request.getParameter("stock");
        
        if (title != null && !title.trim().isEmpty() && 
            author != null && !author.trim().isEmpty() &&
            stockStr != null && !stockStr.trim().isEmpty()) {
            
            Book book = new Book();
            book.setTitle(title);
            book.setAuthor(author);
            book.setStock(Integer.parseInt(stockStr));
            
            boolean success = bookDao.add(book);
            
            if (success) {
                response.sendRedirect("bookList");
            } else {
                request.setAttribute("error", "添加图书失败");
                request.getRequestDispatcher("addBook.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "请填写完整信息");
            request.getRequestDispatcher("addBook.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("addBook.jsp").forward(request, response);
    }
}
