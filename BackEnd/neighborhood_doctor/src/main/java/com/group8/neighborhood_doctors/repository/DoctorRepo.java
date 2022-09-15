package com.group8.neighborhood_doctors.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.group8.neighborhood_doctors.doctor.Doctor;

@Repository
public interface DoctorRepo extends JpaRepository<Doctor, Integer> {
    public boolean existsById(int id);
    public boolean existsByFirstname(String firstname);
    public boolean existsByLastname(String lastname);

    @Query("select max(s.id) from Doctor s")
    public Integer findMaxId();
}
