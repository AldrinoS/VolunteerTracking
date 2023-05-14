package com.example.volunteertracking.controller;

import com.example.volunteertracking.model.NGOEvent;
import com.example.volunteertracking.repo.NGOEventRepository;
import com.example.volunteertracking.service.AppService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@Controller("app")
public class AppController {

    @Autowired
    NGOEventRepository repository;

    @Autowired
    AppService appService;

    @GetMapping("home")
    public String getHomePage(@RequestParam(required = false) String option, ModelMap model) {
        List<NGOEvent> events = new ArrayList<>();
        if (option != null) {
            if (option.equalsIgnoreCase("myEvents")) {
                events = repository.findByUsername("aldrino");

            } else if (option.equalsIgnoreCase("eventsVolunteered")) {
                events = appService.getVolunteeredEvents("aldrino");

            } else if (option.equalsIgnoreCase("upcomingEvents")) {
                events = appService.getUpcomingEvents();
            }
        } else {
            events = repository.findByUsername("aldrino");
        }

        model.addAttribute("events", events);
        return "home.jsp";
    }

    @GetMapping("create-event")
    public String showCreateEventPage(ModelMap model) {
        NGOEvent event = new NGOEvent("", "", "", "", "", "");
        model.addAttribute("ngoEvent", event);

        return "createEvent.jsp";

    }

    @PostMapping("create-event")
    public String addNewEvent(@Valid NGOEvent ngoEvent, BindingResult result) {

        if(result.hasErrors()) {
            return "createEvent.jsp";
        }

        ngoEvent.setUsername("aldrino");
        ngoEvent.setNoOfVolunteers(0);
        ngoEvent.setVolunteers(new ArrayList<>());
        repository.save(ngoEvent);

        return "redirect:home";

    }

}
