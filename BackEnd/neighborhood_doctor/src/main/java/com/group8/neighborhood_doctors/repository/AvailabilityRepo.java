package com.group8.neighborhood_doctors.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.group8.neighborhood_doctors.availability.Availability;

@Repository
public interface AvailabilityRepo extends JpaRepository<Availability, Integer> {
    public boolean existsById(int id);

    public boolean existsByDoctorId(int doctorId);
    public boolean existsByDate(String date);
    public boolean existsByStatus(String status);
    public boolean existsByStart(String start);
    public boolean existsByEnd(String end);

    @Query("select max(s.id) from Availability s")
    public Integer findMaxId();
}