package com.mvc.dao;

import java.sql.*;
import com.mvc.model.Election;
import com.mvc.util.DBConnection;

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
}
