package com.mvc.dao;

import java.sql.*;
import com.mvc.util.DBConnection;

public class ResultDAO {

    public ResultSet getResultsByElection(int electionId) {
        ResultSet rs = null;
        try {
            Connection con = DBConnection.getConnection();
            String sql = 
              "SELECT c.name, COUNT(v.vote_id) AS total " +
              "FROM candidates c " +
              "LEFT JOIN votes v ON c.candidate_id = v.candidate_id " +
              "WHERE c.election_id=? " +
              "GROUP BY c.candidate_id";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, electionId);
            rs = ps.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }
}
