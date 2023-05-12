package com.example.volunteertracking.model;

import javax.persistence.*;
import java.util.List;

@Entity
public class NGOEvent {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String username;
    private String contactNumber;
    private String eventName;
    private String eventDesc;
    private String eventLocation;
    private String eventDate;
    private int noOfVolunteers;
    @ElementCollection
    private List<String> volunteers;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getEventDesc() {
        return eventDesc;
    }

    public void setEventDesc(String eventDesc) {
        this.eventDesc = eventDesc;
    }

    public String getEventLocation() {
        return eventLocation;
    }

    public void setEventLocation(String eventLocation) {
        this.eventLocation = eventLocation;
    }

    public String getEventDate() {
        return eventDate;
    }

    public void setEventDate(String eventDate) {
        this.eventDate = eventDate;
    }

    public int getNoOfVolunteers() {
        return noOfVolunteers;
    }

    public void setNoOfVolunteers(int noOfVolunteers) {
        this.noOfVolunteers = noOfVolunteers;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String eventAdmin) {
        this.username = eventAdmin;
    }

    public List<String> getVolunteers() {
        return volunteers;
    }

    public void setVolunteers(List<String> volunteers) {
        this.volunteers = volunteers;
    }

    @Override
    public String toString() {
        return "NGOEvent{" +
                "id=" + id +
                ", eventAdmin='" + username + '\'' +
                ", contactNumber='" + contactNumber + '\'' +
                ", eventName='" + eventName + '\'' +
                ", eventDesc='" + eventDesc + '\'' +
                ", eventLocation='" + eventLocation + '\'' +
                ", eventDate='" + eventDate + '\'' +
                ", noOfVolunteers=" + noOfVolunteers +
                ", volunteers=" + volunteers +
                '}';
    }
}
