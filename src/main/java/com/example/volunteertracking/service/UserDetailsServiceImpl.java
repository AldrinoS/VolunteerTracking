package com.example.volunteertracking.service;

import com.example.volunteertracking.model.Volunteer;
import com.example.volunteertracking.repo.VolunteerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
  @Autowired
  VolunteerRepository repository;

  @Override
  @Transactional
  public UserDetails loadUserByUsername(String number) throws UsernameNotFoundException {
    Volunteer user = repository.findByNumber(number)
        .orElseThrow(() -> new UsernameNotFoundException("User Not Found with contact number: " + number));

    return UserDetailsImpl.build(user);
  }

}
