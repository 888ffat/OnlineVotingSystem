package com.mvc.model;

public class Election {
    private int electionId;
    private String title;
    private String description;
    private String startDate;
    private String endDate;
    private String status;

    public int getElectionId() { return electionId; }
    public void setElectionId(int electionId) { this.electionId = electionId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }

    public String getEndDate() { return endDate; }
    public void setEndDate(String endDate) { this.endDate = endDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
