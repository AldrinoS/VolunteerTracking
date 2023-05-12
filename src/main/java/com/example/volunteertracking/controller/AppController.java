package com.example.volunteertracking.controller;

import com.example.volunteertracking.model.NGOEvent;
import com.example.volunteertracking.repo.NGOEventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller("app")
public class AppController {

    @Autowired
    NGOEventRepository repository;

    @GetMapping("home")
    public String getHomePage(ModelMap model) {
        List<NGOEvent> events = repository.findByUsername("aldrino");
        model.addAttribute("events", events);
        return "home.jsp";
    }

}
