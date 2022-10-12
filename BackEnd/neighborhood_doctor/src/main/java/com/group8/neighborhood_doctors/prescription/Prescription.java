package com.group8.neighborhood_doctors.prescription;

// id: int
// date
// time start
// time end
// doctor id
// patient id
// description
// medication id

public class Prescription {
    private int id;

    private int patientId;
    @NotNull(message = "Date cannot be null")
    private String date;
    @NotNull(message = "Description name cannot be null")
    private String description;
    @NotNull(message = "medicationId name cannot be null")
    private int medicationId;

    public int getId() {
        return id;
    }
    public void setId(int id) {this.is = id;}

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

    @Override
    public String toString() {
        return "Prescription{" +
                "id=" + id +
                ", patientId='" + patientId + '\'' +
                ", medicationId='" + medicationId + '\'' +
                ", date='" + date + '\'' +
                ", description=" + description +
                '}';
    }
}
