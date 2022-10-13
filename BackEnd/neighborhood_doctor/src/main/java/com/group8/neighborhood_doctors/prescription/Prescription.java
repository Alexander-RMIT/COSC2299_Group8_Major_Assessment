package com.group8.neighborhood_doctors.prescription;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
// id: int
// date
// time start
// time end
// doctor id
// patient id
// description
// medication id
@Entity
@Table(name = "Prescription")
public class Prescription {
    @Id
    private int id;

    private int patientId;
    @NotNull(message = "Date cannot be null")
    private String date;
    @NotNull(message = "Description name cannot be null")
    private String description;
    @NotNull(message = "medicationId name cannot be null")
    private int medicationId;

    @NotNull(message = "name must not be null")
    private String name;


    public int getId() {
        return id;
    }
    public void setId(int id) {this.id = id;}

    public String getDate(){return date;}
    public void setDate(String date){this.date=date;}

    public String getDescription(){return description;}
    public void setDescription(String description){this.description = description;}

    public int getMedicationId(){return medicationId;}
    public void setMedicationId(int medicationId){this.medicationId = medicationId;}

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }
    public int getPatientId() {
        return patientId;
    }

    public void setName(String name){this.name = name;}
    public String getName(){return name;}

    @Override
    public String toString() {
        return "Prescription{" +
                "id=" + id +
                ", patientId='" + patientId + '\'' +
                ", medicationId='" + medicationId + '\'' +
                ", name='" + name + '\'' +
                ", date='" + date + '\'' +
                ", description=" + description +
                '}';
    }
}
