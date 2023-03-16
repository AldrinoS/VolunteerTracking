package com.example.volunteertracking.service;

import com.example.volunteertracking.model.NGOEvent;
import com.example.volunteertracking.repo.NGOEventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class AppService {

    @Autowired
    NGOEventRepository repository;

    public void saveEvent(NGOEvent event) {
        event.setVolunteers(new ArrayList<String>());
        System.out.println(repository.save(event));

    }

    public List<NGOEvent> getAllEvents() {
        return repository.findAll();
    }

    public void deleteAllEvents() {
        repository.deleteAll();
    }

    public void updateEventVolunteer(String userId, int eventId) {
        Optional<NGOEvent> event = repository.findById(eventId);
        if(event.isPresent()) {
            NGOEvent currentEvent = event.get();
            currentEvent.setNoOfVolunteers(currentEvent.getNoOfVolunteers()+1);
            currentEvent.getVolunteers().add(userId);
            repository.save(currentEvent);
        }
    }
}
