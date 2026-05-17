package com.library.servlet;

import com.library.dao.BookDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/borrowBook")
public class BorrowBookServlet extends HttpServlet {

    private BookDao bookDao = new BookDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            int id = Integer.parseInt(idStr);
            boolean success = bookDao.borrow(id);
            
            if (!success) {
                request.getSession().setAttribute("error", "借阅失败，可能库存不足");
            } else {
                request.getSession().setAttribute("success", "借阅成功");
            }
        }
        
        response.sendRedirect("bookList");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
