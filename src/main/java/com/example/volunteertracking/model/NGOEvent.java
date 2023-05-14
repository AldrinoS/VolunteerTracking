package com.example.volunteertracking.model;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.List;

@Entity
public class NGOEvent {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String username;
//    @Size(max = 10, min = 10, message = "Please enter contact number that is 10 digits")
    private String contactNumber;
//    @NotBlank(message = "Event Name is required")
    private String eventName;
//    @Size(min = 5, message = "Enter description that is minimum 5 characters long")
    private String eventDesc;
//    @NotBlank(message = "Event Location is required")
    private String eventLocation;
//    @NotBlank(message = "Event Date is required")
    private String eventDate;
    private int noOfVolunteers;
    @ElementCollection
    private List<String> volunteers;

    public NGOEvent() {
    }

    public NGOEvent(String username, String contactNumber, String eventName, String eventDesc, String eventLocation, String eventDate) {
        this.username = username;
        this.contactNumber = contactNumber;
        this.eventName = eventName;
        this.eventDesc = eventDesc;
        this.eventLocation = eventLocation;
        this.eventDate = eventDate;
    }

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
