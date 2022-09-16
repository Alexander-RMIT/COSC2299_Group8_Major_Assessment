package com.group8.neighborhood_doctors.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.group8.neighborhood_doctors.administrator.Administrator;

// import java.util.List;

@Repository
public interface AdministratorRepo extends JpaRepository<Administrator, Integer> {
    public boolean existsById(int id);
    public boolean existsByUsername(String username);

    @Query("select max(s.id) from Administrator s")
    public Integer findMaxId();
}
