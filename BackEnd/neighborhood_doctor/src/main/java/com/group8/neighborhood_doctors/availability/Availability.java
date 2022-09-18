package com.group8.neighborhood_doctors.availability;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Availability {

    @Id
    private int id;

    private int doctorId;
    private String date;
    private String status;
    private String start;
    private String end;

    public Availability() {
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getDoctorId() {
        return doctorId;
    }
    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }

    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) { 
        this.status = status;
    }

    public String getStart() {
        return start;
    }
    public void setStart(String start) { 
        this.start = start;
    }

    public String getEnd() {
        return end;
    }
    public void setEnd(String end) { 
        this.end = end;
    }

    @Override
    public String toString() {
        return "administrator{" +
                "id=" + id +
                ", doctorId='" + doctorId + '\'' +
                ", date='" + date + '\'' +
                ", status='" + status + '\'' +
                ", start='" + start + '\'' +
                ", end='" + end + '\'' +
                '}';
    }
    
}
