package com.example.volunteertracking.service;

import com.example.volunteertracking.model.Volunteer;
import com.example.volunteertracking.repo.VolunteerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VolunteerService {

    @Autowired
    VolunteerRepository volunteerRepository;

    @Autowired
    PasswordEncoder encoder;

    public void saveUser(Volunteer volunteer) throws Exception {
        if(volunteerRepository.existsByNumber(volunteer.getNumber())) {
            throw new Exception("");
        }
        volunteer.setPassword(encoder.encode(volunteer.getPassword()));
        volunteerRepository.save(volunteer);
    }

    public void deleteAllUser() {
        volunteerRepository.deleteAll();
    }

    public List<Volunteer> getAllVolunteer() {
        return volunteerRepository.findAll();
    }
}
