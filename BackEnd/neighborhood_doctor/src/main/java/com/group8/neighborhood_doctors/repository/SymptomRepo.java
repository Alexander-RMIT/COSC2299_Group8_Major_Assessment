package com.group8.neighborhood_doctors.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.group8.neighborhood_doctors.symptom.Symptom;

@Repository
public interface SymptomRepo extends JpaRepository<Symptom, Integer> {
    public boolean existsByPatientId(int patientId);

    public Optional<Symptom> findByPatientId(int patientId);
    
    @Query("select max(s.id) from Symptom s")
    public Integer findMaxId();
}
