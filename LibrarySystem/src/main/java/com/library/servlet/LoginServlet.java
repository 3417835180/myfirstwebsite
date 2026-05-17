package com.library.servlet;

import com.library.dao.UserDao;
import com.library.pojo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

// ⚠️注意：这个注解表示网页只要访问 /login 路径，就会触发这个 Servlet
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. 设置请求编码，防止前端传过来的中文账号乱码
        request.setCharacterEncoding("UTF-8");

        // 2. 接收前端表单传过来的账号和密码
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 3. 调用 Dao 层去数据库比对
        User user = userDao.login(username, password);

        if (user != null) {
            // 4. 登录成功！把用户信息存入 Session（会话管理，证明这人登录过了）
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // 5. 重定向到主页（我们后面会建 index.jsp）
            response.sendRedirect("index.jsp");
        } else {
            // 6. 登录失败！在请求里塞一个错误提示，再弹回登录页面
            request.setAttribute("error", "账号或密码错误，请重试！");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 如果是用 get 方式请求（比如直接在浏览器输入地址），我们也让他走 post 同样的逻辑
        doPost(request, response);
    }
}