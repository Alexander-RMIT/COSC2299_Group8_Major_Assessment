package com.group8.neighborhood_doctors.entity;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class administrator {
    
    @Id
    private int id;

    private String username;
    private String password;

    public administrator() {
    }

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "administrator{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

}
