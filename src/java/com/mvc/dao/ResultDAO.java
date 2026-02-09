package com.mvc.dao;

import java.sql.*;
import java.util.*;
import com.mvc.util.DBConnection;
//
public class ResultDAO {

    // Returns a list of candidate results for a given election
    public List<Map<String, Object>> getResultsByElection(int electionId) {
        List<Map<String, Object>> results = new ArrayList<>();
        int totalVotes = 0;

        String sql = "SELECT c.name, COUNT(v.vote_id) AS total " +
                     "FROM candidates c " +
                     "LEFT JOIN votes v ON c.candidate_id = v.candidate_id " +
                     "WHERE c.election_id=? " +
                     "GROUP BY c.candidate_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, electionId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("name", rs.getString("name"));
                    int votes = rs.getInt("total");
                    row.put("total", votes);

                    results.add(row);
                    totalVotes += votes;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Optionally, you could return totalVotes separately if needed
        return results;
    }
}
