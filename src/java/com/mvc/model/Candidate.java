package com.mvc.model;

public class Candidate {
    private int candidateId;
    private int electionId;
    private String name;
    private String manifesto;
    private String photo;

    public int getCandidateId() { return candidateId; }
    public void setCandidateId(int candidateId) { this.candidateId = candidateId; }

    public int getElectionId() { return electionId; }
    public void setElectionId(int electionId) { this.electionId = electionId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getManifesto() { return manifesto; }
    public void setManifesto(String manifesto) { this.manifesto = manifesto; }

    public String getPhoto() { return photo; }
    public void setPhoto(String photo) { this.photo = photo; }
}
