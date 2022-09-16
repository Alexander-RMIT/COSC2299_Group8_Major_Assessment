package com.group8.neighborhood_doctors.appointment;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Appointment {
    @Id
    private int id;

    private String date;
    private String timeStart;
    private String timeEnd;
    private int doctorId;
    private int patientId;
    private String description;

    public Appointment() {
    }

    public int getId() {
        return id;
    }

    public String getDate() {
        return date;
    }

    public String getTimeStart() {
        return timeStart;
    }

    public String getTimeEnd() {
        return timeEnd;
    }

    public int getDoctorId() {
        return doctorId;
    }

    public int getPatientId() {
        return patientId;
    }

    public String getDescription() {
        return description;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setTimeStart(String timeStart) {
        this.timeStart = timeStart;
    }

    public void setTimeEnd(String timeEnd) {
        this.timeEnd = timeEnd;
    }

    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Appointment{" +
                "id=" + id +
                ", date='" + date + '\'' +
                ", timeStart='" + timeStart + '\'' +
                ", timeEnd='" + timeEnd + '\'' +
                ", doctorId=" + doctorId +
                ", patientId=" + patientId +
                ", description='" + description + '\'' +
                '}';
    }
}
