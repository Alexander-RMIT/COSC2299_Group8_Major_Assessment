package com.group8.neighborhood_doctors.repository;

import com.group8.neighborhood_doctors.entity.administrator;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdministratorRepo extends JpaRepository<administrator, Integer> {
    public boolean existsById(int id);

    public List<administrator> findByPassword(String psw);

    @Query("select max(s.id) from administrator s")
    public Integer findMaxId();
}
