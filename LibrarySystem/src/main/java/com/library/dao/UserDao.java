package com.library.dao;

import com.library.pojo.User;
import com.library.utils.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao {

    /**
     * 根据用户名和密码查询用户（用于登录验证）
     * 答辩加分点：我们使用了 PreparedStatement，可以有效防止 SQL 注入攻击！
     */
    public User login(String username, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;

        try {
            // 1. 获取数据库连接
            conn = DBUtil.getConnection();

            // 2. 编写 SQL 语句（用 ? 作为占位符）
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

            // 3. 预编译 SQL
            ps = conn.prepareStatement(sql);

            // 4. 塞入具体的参数值
            ps.setString(1, username);
            ps.setString(2, password);

            // 5. 执行查询，获取结果集
            rs = ps.executeQuery();

            // 6. 如果查到了匹配的用户，就把他封装成 User 对象
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 7. 关闭资源，防止内存泄漏
            DBUtil.closeAll(rs, ps, conn);
        }

        // 如果没查到，会返回 null；查到了，就返回带有权限的角色对象
        return user;
    }
}
