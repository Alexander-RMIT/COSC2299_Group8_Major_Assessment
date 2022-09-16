package com.group8.neighborhood_doctors.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.group8.neighborhood_doctors.patient.Patient;

@Repository
public interface PatientRepo extends JpaRepository<Patient, Integer> {
    public boolean existsById(int id);

    public boolean existsByFirstname(String firstname);
    public boolean existsByLastname(String lastname);
    public boolean existsByNameother(String nameother);
    public boolean existsByEmail(String email);

    @Query("select max(s.id) from Patient s")
    public Integer findMaxId();
}
