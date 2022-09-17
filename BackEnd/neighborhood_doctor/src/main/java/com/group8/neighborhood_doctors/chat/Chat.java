package com.group8.neighborhood_doctors.chat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.persistence.Id;

@Entity
@Table(name = "chat")
public class Chat {
    @Id
    private int id;

    @Column(name = "time")
    @NotEmpty(message = "Error when system try to get real-time")
    private String time;

    @Column(name = "message")
    private String message;

    @NotNull(message = "userone id should not be empty")
    private int userone; // Doctor id

    @NotNull(message = "userone id should not be empty")
    private int usertwo; // Patient id
    
    public Chat() {
    }

    public int getId() {
        return id;
    }

    public String getTime() {
        return time;
    }

    public String getMessage() {
        return message;
    }

    public int getUserone() {
        return userone;
    }

    public int getUsertwo() {
        return usertwo;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setUserone(int userone) {
        this.userone = userone;
    }

    public void setUsertwo(int usertwo) {
        this.usertwo = usertwo;
    }

    @Override
    public String toString() {
        return "Chat{" +
                "id=" + id +
                ", time='" + time + '\'' +
                ", message='" + message + '\'' +
                ", userone=" + userone +
                ", usertwo=" + usertwo +
                '}';
    }
}
