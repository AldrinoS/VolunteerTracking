package com.example.volunteertracking.controller;

import com.example.volunteertracking.model.NGOEvent;
import com.example.volunteertracking.service.AppService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@Controller
public class AppController {

    @Autowired
    AppService appService;

    @GetMapping("/register")
    public String registerUser(Model model) {
        return "register.jsp";
    }

    @GetMapping("/login")
    public String loginUser(Model model, @RequestParam(required = false) String pass) {
//        model.addAttribute("UUID", pass);
        return "login.jsp";
    }

    @GetMapping("/create-event")
    public String createEvent(Model model) {
        model.addAttribute("a", new ArrayList<Integer>());
        return "create-event.jsp";
    }

    @GetMapping("/home")
    public String homePage(Model model) {
        return "home.jsp";
    }

    @PostMapping("/add-event")
    public ResponseEntity<?> addNGOEvent(@Valid @RequestBody NGOEvent ngoEvent) {
        appService.saveEvent(ngoEvent);

        return ResponseEntity.ok("Event Saved");
    }

    @GetMapping("/get-events")
    public ResponseEntity<List<NGOEvent>> getAllEvents() {
        List<NGOEvent> events = appService.getAllEvents();
        System.out.println(events);
        return new ResponseEntity<>(events, HttpStatus.OK);


    }

    @DeleteMapping("/delete-events")
    public ResponseEntity<?> deleteAllEvents() {
        appService.deleteAllEvents();

        return ResponseEntity.ok("Deleted All Events");
    }

    @PatchMapping("/update-event-volunteers")
    public ResponseEntity<?> updateVolunteers(@RequestParam String userId, @RequestParam int eventId) {
        appService.updateEventVolunteer(userId, eventId);

        return ResponseEntity.ok().build();
    }


}
