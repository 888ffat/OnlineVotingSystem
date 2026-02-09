package com.mvc.dao;

import java.sql.*;
import com.mvc.model.User;
import com.mvc.util.DBConnection;
//
public class UserDAO {

    // Register user
    public boolean register(User user) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO users(full_name, matric_no, email, password, role) VALUES(?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getMatricNo());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());

            status = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Login user
    public User login(String matricNo, String password) {
        User user = null;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM users WHERE matric_no=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, matricNo);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setMatricNo(rs.getString("matric_no"));
                user.setRole(rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public int getTotalStudents() {
    int count = 0;
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM users WHERE role='voter'";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) count = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}

}
