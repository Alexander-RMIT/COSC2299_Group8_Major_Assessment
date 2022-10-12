package com.group8.neighborhood_doctors.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.query.Param;

import com.group8.neighborhood_doctors.symptom.Symptom;

@Repository
public interface SymptomRepo extends JpaRepository<Symptom, Integer> {
    public boolean existsByPatientId(int patientId);

    public boolean existsByName(String name);

    public Optional<Symptom> findByPatientId(int patientId);
    
    @Query("select max(s.id) from Symptom s")
    public Integer findMaxId();

    @Query("SELECT s FROM Symptom s WHERE s.patientId=:patientId")
    public List<Symptom> findNameByPatientId(@Param("patientId") int patientId);
}
