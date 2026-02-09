package com.mvc.dao;

import java.sql.*;
import com.mvc.model.Candidate;
import com.mvc.util.DBConnection;
//
public class CandidateDAO {

    public boolean addCandidate(Candidate c) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO candidates(election_id, name, manifesto) VALUES(?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, c.getElectionId());
            ps.setString(2, c.getName());
            ps.setString(3, c.getManifesto());

            status = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public ResultSet getCandidatesByElection(int electionId) {
        ResultSet rs = null;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM candidates WHERE election_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, electionId);
            rs = ps.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public int getTotalCandidates() {
        int count = 0;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM candidates";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public void updateCandidate(int id, String name, String manifesto) {
        String sql = "UPDATE candidates SET name=?, manifesto=? WHERE candidate_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, manifesto);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCandidate(int id) {
        String sql = "DELETE FROM candidates WHERE candidate_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
