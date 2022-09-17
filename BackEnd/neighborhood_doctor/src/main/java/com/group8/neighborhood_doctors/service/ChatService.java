package com.group8.neighborhood_doctors.service;

import com.group8.neighborhood_doctors.chat.Chat;

import com.group8.neighborhood_doctors.repository.ChatRepo;
import com.group8.neighborhood_doctors.repository.DoctorRepo;
import com.group8.neighborhood_doctors.repository.PatientRepo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;

@Service
public class ChatService {

    @Autowired
    private ChatRepo chatRepo;

    @Autowired
    private DoctorRepo doctorRepo;

    @Autowired
    private PatientRepo patientRepo;

    @Transactional
    public String createChat(Chat chat) {
        try {
            // Check if user1 id exists in doctor table
            if (doctorRepo.existsById(chat.getUserone())) {
                // Check if user2 id exists in patient table
                if (patientRepo.existsById(chat.getUsertwo())) {
                    // Check if chat already exists in the database
                    if (!(chatRepo.existsByUserone(chat.getUserone()) && chatRepo.existsByUsertwo(chat.getUsertwo()))) {
                        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                        LocalDateTime now = LocalDateTime.now();
                        chat.setId(null == chatRepo.findMaxId()? 1 : chatRepo.findMaxId() + 1);
                        chat.setTime(dtf.format(now));
                        chatRepo.save(chat);
                        return "[SUCCESS] Chat session created successfully.";
                    } else {
                        return "[FAILED] Reason: Chat session already exists in the database.";
                    }
                } else {
                    return "[FAILED] Reason: Patient does not exist in the database.";
                }
            } else {
                return "[FAILED] Reason: Doctor does not exist in the database.";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public List<Chat> readChats() {
        return chatRepo.findAll();
    }

    @Transactional
    public String deleteChat(Chat chat) {
        if (chatRepo.existsById(chat.getId())) {
            try {
                Optional<Chat> chats = chatRepo.findById(chat.getId());
                chats.stream().forEach(s -> {
                    chatRepo.delete(s);
                });
                return "[SUCCESS] Chat session has been deleted successfully.";
            } catch (Exception e) {
                throw e;
            }

        } else {
            return "[FAILED] Reason: Chat session does not exist";
        }
    }
    
}
