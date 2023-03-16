package com.example.volunteertracking.repo;

import com.example.volunteertracking.model.Volunteer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface VolunteerRepository extends JpaRepository<Volunteer, Integer> {

    Optional<Volunteer> findByName(String name);

    Optional<Volunteer> findByNumber(String number);

    Boolean existsByName(String name);
    Boolean existsByNumber(String number);

//    Boolean existsByEmail(String email);
}
