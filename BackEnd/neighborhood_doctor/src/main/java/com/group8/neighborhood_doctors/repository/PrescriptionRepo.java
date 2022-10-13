package com.group8.neighborhood_doctors.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.query.Param;

import com.group8.neighborhood_doctors.prescription.Prescription;

@Repository
public interface PrescriptionRepo extends JpaRepository<Prescription, Integer> {
    public boolean existsByPatientId(int patientId);
    public boolean existsBymedicationId(int medicationId);

    public Optional<Prescription> findByPatientId(int patientId);

    @Query("select max(s.id) from Prescription s")
    public Integer findMaxId();

    @Query("SELECT s FROM Prescription s WHERE s.id=:id")
    public Prescription findPrescriptionById(@Param("id") int Id);
}
