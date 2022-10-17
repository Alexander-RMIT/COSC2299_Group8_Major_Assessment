package com.group8.neighborhood_doctors.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.query.Param;

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
    
    @Query("SELECT s.id FROM Administrator s WHERE s.email=:email AND s.password=:password")
    public Integer findByEmailPassword(@Param("email") String email, 
                                        @Param("password") String password);
    
    @Query("SELECT s.username FROM Administrator s WHERE s.id=:id")
    public String findUsernameById(@Param("id") int id);

    @Query("SELECT s FROM Administrator s WHERE s.id=:id")
    public Administrator getById(@Param("id")int id);
}
