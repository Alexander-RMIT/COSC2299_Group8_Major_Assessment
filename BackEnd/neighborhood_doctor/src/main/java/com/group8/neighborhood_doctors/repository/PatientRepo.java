package com.group8.neighborhood_doctors.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.query.Param;
import com.group8.neighborhood_doctors.patient.Patient;

@Repository
public interface PatientRepo extends JpaRepository<Patient, Integer> {
    public boolean existsById(int id);

    public boolean existsByFirstname(String firstname);
    public boolean existsByLastname(String lastname);
    public boolean existsByNameother(String nameother);
    
    // For authentication
    public boolean existsByEmail(String email);
    public boolean existsByPassword(String password);

    @Query("select max(s.id) from Patient s")
    public Integer findMaxId();
    
    @Query("SELECT s.id FROM Patient s WHERE s.email=:email AND s.password=:password")
    public Integer findByEmailPassword(@Param("email") String email, 
                                        @Param("password") String password);
    
    @Query("SELECT s.firstname FROM Patient s WHERE s.id=:id")
    public String findNameById(@Param("id") int id);


    @Query("SELECT s FROM Patient s WHERE s.id=:id")
    public Patient getById(@Param("id")int id);

    @Query("SELECT s FROM Patient s WHERE s.email=:email")
    public Patient getByEmail(@Param("email")String email);

}
