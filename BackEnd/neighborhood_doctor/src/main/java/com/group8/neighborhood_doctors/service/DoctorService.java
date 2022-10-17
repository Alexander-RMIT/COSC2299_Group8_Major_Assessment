package com.group8.neighborhood_doctors.service;

import com.group8.neighborhood_doctors.doctor.Doctor;
import com.group8.neighborhood_doctors.repository.DoctorRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class DoctorService {
    @Autowired
    private DoctorRepo doctorRepo;

    /*
    Create new doctor to the database
    */
    @Transactional
    public String createDoctor(Doctor doctor) {
        try {
            if (!(doctorRepo.existsByFirstname(doctor.getFirstname()) && doctorRepo.existsByLastname(doctor.getLastname()))) {
                doctor.setId(null == doctorRepo.findMaxId()? 1 : doctorRepo.findMaxId() + 1);
                doctorRepo.save(doctor);
                return "[SUCCESS] Doctor record created successfully.";
            } else {
                return "[FAILED] Reason: Doctor already exists in the database.";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    /*
    Get all the doctors from the database
    */
    public List<Doctor> readDoctors() {
        return doctorRepo.findAll();
    }

    /*
    Update doctor info from the database
    */
    @Transactional
    public String updateDoctor(Doctor doctor) {
        if (doctorRepo.existsById(doctor.getId())) {
            try {
                Optional<Doctor> doctors = doctorRepo.findById(doctor.getId());
                doctors.stream().forEach(s -> {
                    Doctor doctorToBeUpdate = doctorRepo.findById(s.getId()).get();
                    doctorToBeUpdate.setFirstname(doctor.getFirstname());
                    doctorToBeUpdate.setLastname(doctor.getLastname());
                    doctorToBeUpdate.setEmail(doctor.getEmail());
                    doctorToBeUpdate.setPassword(doctor.getPassword());
                    doctorRepo.save(doctorToBeUpdate);
                });
                return "[SUCCESS] Doctor record updated.";
            } catch (Exception e) {
                throw e;
            }
        } else {
            return "[FAILED] Reason: Doctor does not exists in the database.";
        }
    }

    /*
    Remove doctor from the database
    */
    @Transactional
    public String deleteDoctor(Doctor doctor) {
        if (doctorRepo.existsById(doctor.getId())) {
            try {
                Optional<Doctor> doctors = doctorRepo.findById(doctor.getId());
                doctors.stream().forEach(s -> {
                    doctorRepo.delete(s);
                });
                return "[SUCCESS]Doctor record deleted successfully.";
            } catch (Exception e) {
                throw e;
            }

        } else {
            return "[FAILED] Reason: Doctor does not exist";
        }
    }
    
    
    
    /*
     * Find doctor in the database by email and password
     */
    @Transactional
    public String findDoctor(Doctor doctor) {
        try {
            if (doctorRepo.existsByEmail(doctor.getEmail()) && doctorRepo.existsByPassword(doctor.getPassword())) {
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
    public String retrieveId(Doctor doctor) {
        if (doctorRepo.existsByEmail(doctor.getEmail()) && doctorRepo.existsByPassword(doctor.getPassword())) {
            try {
                // If the patient exists in the database
                int id = doctorRepo.findByEmailPassword(doctor.getEmail(), doctor.getPassword());
                return "" + id;
                
            } catch (Exception e) {
                throw e;
            }
        } else {
            return "Doctor not in database, try again.";
        }
    }
    
    // Retrieve doctor first name by id
    @Transactional
    public String retrieveFirstName(int id) {
        try {
            String fname = doctorRepo.findNameById(id);
            return fname;
        } catch (Exception e) {
            throw e;
        }
    }

    public Optional<Doctor> find(int id) throws Exception {
        if (doctorRepo.existsById(id)) {
            return doctorRepo.findById(id);
        }
        else {
            throw new Exception("[FAILED] Account ID:{" + id + "} does not exist");
        }
    }
}
