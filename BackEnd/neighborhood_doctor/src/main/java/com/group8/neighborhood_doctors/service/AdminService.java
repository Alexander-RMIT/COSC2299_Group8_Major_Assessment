package com.group8.neighborhood_doctors.service;

import com.google.gson.Gson;

import com.group8.neighborhood_doctors.administrator.Administrator;
import com.group8.neighborhood_doctors.repository.AdministratorRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.HashMap;


@Service
public class AdminService {
    @Autowired
    private AdministratorRepo adminRepo;

    @Transactional
    public String createAdmin(Administrator admin){
        try {
            if (!adminRepo.existsByUsername(admin.getUsername())) {
                admin.setId(null == adminRepo.findMaxId()? 1 : adminRepo.findMaxId() + 1);
                adminRepo.save(admin);
                return "[SUCCESS] Admin record created successfully.";
            } else {
                return "[FAILED] Reason: Admin already exists in the database.";
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
                return "[SUCCESS] Admin record updated.";
            } catch (Exception e) {
                throw e;
            }
        } else {
            return "[FAILED] Reason: Admin does not exists in the database.";
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
                return "[SUCCESS] Admin record deleted successfully.";
            } catch (Exception e) {
                throw e;
            }

        } else {
            return "[FAILED] Reason: Admin does not exist";
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
    
    // Retrieving the admin username by their id
    @Transactional
    public String retrieveUsername(int id) {
        try {
            String uname = adminRepo.findUsernameById(id);
            return uname;
        } catch (Exception e) {
            throw e;
        }
    }

    public Optional<Administrator> find(int id) throws Exception {
        if (adminRepo.existsById(id)) {
            return adminRepo.findById(id);
        }
        else {
            throw new Exception("[FAILED] Account ID:{" + id + "} does not exist");
        }
    }

    /*
    Get all the admins from the database
    */
    public String readAdminsString() {
        List<Administrator> admins = adminRepo.findAll();
        // username    password    email   
        String strAdmins = "[";

        for (int i = 0; i < admins.size(); i++) {
            Administrator curAdmin = admins.get(i);
            // Format to be a map
            Map<String, Object> map = new HashMap<>();
            map.put("id", curAdmin.getId());
            map.put("username", curAdmin.getUsername());
            map.put("password", curAdmin.getPassword());
            map.put("email", curAdmin.getEmail());
            Gson gson = new Gson();
            String json = gson.toJson(map);
            

            strAdmins += json;
            
            if (i != admins.size() - 1) {
                strAdmins += ", ";
            }
            
        }
        strAdmins += "]";

        return strAdmins;
    }

    /*
     * Retrieving Admin by their id
     */
    @Transactional 
    public String retrieveAdmin(int id) {
        if (adminRepo.existsById(id)) {
            String admin = "[";
            Administrator a = adminRepo.getById(id);

            Map<String, Object> map = new HashMap<>();
            map.put("id", a.getId());
            map.put("username", a.getUsername());
            map.put("password", a.getPassword());
            map.put("email", a.getEmail());
            Gson gson = new Gson();
            String json = gson.toJson(map);
            
            admin += json;
            admin += "]";
            return admin;

        } else {
            return "admin not in database, try again";
        }
    }
}
