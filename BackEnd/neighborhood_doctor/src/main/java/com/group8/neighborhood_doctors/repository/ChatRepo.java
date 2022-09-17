package com.group8.neighborhood_doctors.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.group8.neighborhood_doctors.chat.Chat;

@Repository
public interface ChatRepo extends JpaRepository<Chat, Integer> {
    public boolean existsById(int id);

    public boolean existsByUserone(int userone);

    public boolean existsByUsertwo(int usertwo);

    @Query("select max(s.id) from Doctor s")
    public Integer findMaxId();
}
