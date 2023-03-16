package com.example.volunteertracking.repo;

import com.example.volunteertracking.model.NGOEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NGOEventRepository extends JpaRepository<NGOEvent, Integer> {
}
