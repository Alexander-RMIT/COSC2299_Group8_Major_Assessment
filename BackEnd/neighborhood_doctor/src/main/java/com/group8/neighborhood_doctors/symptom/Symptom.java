package com.group8.neighborhood_doctors.symptom;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

// Serverity of the symptom
// Note: This is a lookup table

@Entity
@Table(name = "Symptom")
public class Symptom {
    @Id
    private int id;

    // Notice that the name contains muliple symptoms
    // Such as a sentence like "headache, fever, cough"......
    @NotNull(message = "Symptom name cannot be null")
    private String name;

    @NotNull(message = "Patient ID is required")
    private int patientId;

    @NotEmpty(message = "Symptom severity cannot be empty")
    private String severity;

    private String note;

    public Symptom() {
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getPatientId() {
        return patientId;
    }

    public String getSeverity() {
        return severity;
    }

    public String getNote() {
        return note;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "Symptom{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", patientId=" + patientId +
                ", severity='" + severity + '\'' +
                ", note='" + note + '\'' +
                '}';
    }

}
