package com.example.volunteertracking.service;

import com.example.volunteertracking.model.NGOEvent;
import com.example.volunteertracking.repo.NGOEventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AppService {

    @Autowired
    NGOEventRepository ngoEventRepository;

    public List<NGOEvent> getVolunteeredEvents(String username) {
        List<NGOEvent> allEvents = ngoEventRepository.findAll();
        List<NGOEvent> eventsVolunteered = allEvents.stream().filter(ngoEvent -> ngoEvent.getVolunteers().contains(username)).collect(Collectors.toList());

        return eventsVolunteered;
    }

    public List<NGOEvent> getUpcomingEvents() {
        List<NGOEvent> allEvents = ngoEventRepository.findAll();
        List<NGOEvent> upcomingEvents = allEvents.stream().filter(ngoEvent -> isUpcomingDate(ngoEvent.getEventDate())).collect(Collectors.toList());

        return upcomingEvents;

    }

    public static boolean isUpcomingDate(String dateStr) {
        // Parse the input date string into a LocalDate object
        LocalDate inputDate = LocalDate.parse(dateStr);

        // Get the current date
        LocalDate currentDate = LocalDate.now();

        // Compare the input date with the current date
        return inputDate.isAfter(currentDate);
    }

}
