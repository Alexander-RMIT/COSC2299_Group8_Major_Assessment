package com.group8.neighborhood_doctors.repository;

import com.group8.neighborhood_doctors.entity.Administrator;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

// import java.util.List;

@Repository
public interface AdministratorRepo extends JpaRepository<Administrator, Integer> {
    public boolean existsById(int id);
    public boolean existsByUsername(String username);

    // public List<administrator> findById(int id);

    @Query("select max(s.id) from Administrator s")
    public Integer findMaxId();
}
