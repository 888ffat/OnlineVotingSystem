package com.mvc.dao;

import java.sql.*;
import com.mvc.model.Election;
import com.mvc.util.DBConnection;
//
public class ElectionDAO {

    public boolean createElection(Election e) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO elections(title, description, start_date, end_date, status) VALUES(?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, e.getTitle());
            ps.setString(2, e.getDescription());
            ps.setString(3, e.getStartDate());
            ps.setString(4, e.getEndDate());
            ps.setString(5, e.getStatus());

            status = ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public ResultSet getAllElections() {
        ResultSet rs = null;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM elections ORDER BY election_id DESC";
            Statement st = con.createStatement();
            rs = st.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public int getTotalElections() {
    int count = 0;
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM elections";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) count = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}

    public int getActiveElections() {
        int count = 0;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM elections WHERE status='active' OR status='Open'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public boolean deleteElection(int id) {
    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps =
            con.prepareStatement("DELETE FROM elections WHERE election_id=?");
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}


}
