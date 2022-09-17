package com.group8.neighborhood_doctors.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.group8.neighborhood_doctors.administrator.Administrator;

@Repository
public interface AdministratorRepo extends JpaRepository<Administrator, Integer> {
    public boolean existsById(int id);
    public boolean existsByUsername(String username);

    // For authentication
    public boolean existsByPassword(String password);
    public boolean existsByEmail(String email);

    @Query("select max(s.id) from Administrator s")
    public Integer findMaxId();
}
