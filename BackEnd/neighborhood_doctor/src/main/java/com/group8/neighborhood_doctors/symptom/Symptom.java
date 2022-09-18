package com.group8.neighborhood_doctors.symptom;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

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

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    @Override
    public String toString() {
        return "Symptom{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", patientId=" + patientId +
                '}';
    }

}
