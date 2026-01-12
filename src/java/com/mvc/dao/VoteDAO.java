package com.mvc.dao;

import java.sql.*;
import com.mvc.util.DBConnection;

public class VoteDAO {

    public boolean hasVoted(int userId, int electionId) {
        boolean voted = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM votes WHERE user_id=? AND election_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, electionId);
            ResultSet rs = ps.executeQuery();
            voted = rs.next();
        } catch (Exception e) { }
        return voted;
    }

    public boolean vote(int userId, int electionId, int candidateId) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO votes(user_id,election_id,candidate_id) VALUES(?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, electionId);
            ps.setInt(3, candidateId);
            status = ps.executeUpdate() > 0;
        } catch (Exception e) { }
        return status;
    }
}
