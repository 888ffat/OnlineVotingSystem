package com.mvc.dao;

import java.sql.*;
import com.mvc.model.Candidate;
import com.mvc.util.DBConnection;

public class CandidateDAO {

    public boolean addCandidate(Candidate c) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO candidates(election_id, name, manifesto, photo) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, c.getElectionId());
            ps.setString(2, c.getName());
            ps.setString(3, c.getManifesto());
            ps.setString(4, c.getPhoto());

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
}
