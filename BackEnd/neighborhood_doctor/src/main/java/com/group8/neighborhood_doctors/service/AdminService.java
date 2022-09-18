package com.group8.neighborhood_doctors.service;

import com.group8.neighborhood_doctors.administrator.Administrator;
import com.group8.neighborhood_doctors.repository.AdministratorRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class AdminService {
    @Autowired
    private AdministratorRepo adminRepo;

    @Transactional
    public String createAdmin(Administrator admin){
        try {
            if (!adminRepo.existsByUsername(admin.getUsername())) {
                admin.setId(null == adminRepo.findMaxId()? 0 : adminRepo.findMaxId() + 1);
                adminRepo.save(admin);
                return "Admin record created successfully.";
            } else {
                return "Admin already exists in the database.";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public List<Administrator> readAdmins() {
        return adminRepo.findAll();
    }

    @Transactional
    public String updateAdmin(Administrator admin) {
        if (adminRepo.existsById(admin.getId())) {
            try {
                Optional<Administrator> admins = adminRepo.findById(admin.getId());
                admins.stream().forEach(s -> {
                    Administrator adminToBeUpdate = adminRepo.findById(s.getId()).get();
                    adminToBeUpdate.setUsername(admin.getUsername());
                    adminToBeUpdate.setPassword(admin.getPassword());
                    adminToBeUpdate.setEmail(admin.getEmail());
                    adminRepo.save(adminToBeUpdate);
                });
                return "Admin record updated.";
            } catch (Exception e) {
                throw e;
            }
        } else {
            return "Admin does not exists in the database.";
        }
    }

    @Transactional
    public String deleteAdmin(Administrator admin) {
        if (adminRepo.existsById(admin.getId())) {
            try {
                Optional<Administrator> admins = adminRepo.findById(admin.getId());
                admins.stream().forEach(s -> {
                    adminRepo.delete(s);
                });
                return "Admin record deleted successfully.";
            } catch (Exception e) {
                throw e;
            }

        } else {
            return "Admin does not exist";
        }
    }
    
    
    /*
     * Check if the admin exists by Email and Password in the database
     */
    @Transactional
    public String findAdmin(Administrator admin) {
        try {
            if (adminRepo.existsByEmail(admin.getEmail()) && adminRepo.existsByPassword(admin.getPassword())) {
                return "Successful login";
            } else {
                return "Incorrect login credentials entered";
            }
        } catch (Exception e) {
            throw e;
        }
    }
    
    /*
     * Retrieve the patient id in the database by email and password
     */
    @Transactional
    public String retrieveId(Administrator admin) {
        if (adminRepo.existsByEmail(admin.getEmail()) && adminRepo.existsByPassword(admin.getPassword())) {
            try {
                // If the patient exists in the database
                int id = adminRepo.findByEmailPassword(admin.getEmail(), admin.getPassword());
                return "" + id;
                
            } catch (Exception e) {
                throw e;
            }
        } else {
            return "Administrator not in database, try again.";
        }
    }
}
