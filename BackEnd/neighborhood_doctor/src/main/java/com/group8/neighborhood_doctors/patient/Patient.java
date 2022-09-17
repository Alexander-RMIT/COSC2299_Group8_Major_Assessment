package com.group8.neighborhood_doctors.patient;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.validation.constraints.NotEmpty;

/*
 * This class represents a patient.
 * A patient is a user of the system.
 */

@Entity
public class Patient {
    @Id
    private int id;

    // The patient's first name cannot be null and empty
    @NotEmpty(message = "First name is required")
    private String firstname;
    
    // The patient's last name cannot be null and empty
    @NotEmpty(message = "Last name is required")
    private String lastname;

    private String nameother;
    private int age;
    private String gender;
    private String address;
    private String phonenumber;

    // The patient's email cannot be null and empty
    @NotEmpty(message = "Email is required")
    private String email;

    // The patient's password cannot be null and empty
    @NotEmpty(message = "Password is required")
    private String password;

    public Patient() {
    }

    public int getId() {
        return id;
    }

    public String getFirstname() {
        return firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public String getNameother() {
        return nameother;
    }

    public int getAge() {
        return age;
    }

    public String getGender() {
        return gender;
    }

    public String getAddress() {
        return address;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public void setNameother(String nameother) {
        this.nameother = nameother;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "administrator{" +
                "id=" + id +
                ", firstname='" + firstname + '\'' +
                ", lastname='" + lastname + '\'' +
                ", nameother='" + nameother + '\'' +
                ", age=" + age +
                ", gender='" + gender + '\'' +
                ", address='" + address + '\'' +
                ", phonenumber='" + phonenumber + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

}
