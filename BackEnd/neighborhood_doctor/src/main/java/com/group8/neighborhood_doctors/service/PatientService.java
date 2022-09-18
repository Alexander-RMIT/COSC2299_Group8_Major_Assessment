package com.group8.neighborhood_doctors.service;

import com.group8.neighborhood_doctors.patient.Patient;
import com.group8.neighborhood_doctors.repository.PatientRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class PatientService {
    @Autowired
    private PatientRepo patientRepo;

    /*
    Create new patient to the database
    */
    @Transactional
    public String createPatient(Patient patient) {
        try {
            if (!(patientRepo.existsByFirstname(patient.getFirstname()) && patientRepo.existsByLastname(patient.getLastname()) && 
                    patientRepo.existsByNameother(patient.getNameother()) && patientRepo.existsByEmail(patient.getEmail()))) {
                patient.setId(null == patientRepo.findMaxId()? 1 : patientRepo.findMaxId() + 1);
                patientRepo.save(patient);
                return "Patient record created successfully.";
            } else {
                return "Patient already exists in the database.";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    /*
    Get all the patients from the database
    */
    public List<Patient> readPatients() {
        return patientRepo.findAll();
    }

    /*
    Update patient info from the database
    */
    @Transactional
    public String updatePatient(Patient patient) {
        if (patientRepo.existsById(patient.getId())) {
            try {
                Optional<Patient> patients = patientRepo.findById(patient.getId());
                patients.stream().forEach(s -> {
                    Patient patientToBeUpdate = patientRepo.findById(s.getId()).get();
                    patientToBeUpdate.setFirstname(patient.getFirstname());
                    patientToBeUpdate.setLastname(patient.getLastname());
                    patientToBeUpdate.setNameother(patient.getNameother());
                    patientToBeUpdate.setAge(patient.getAge());
                    patientToBeUpdate.setGender(patient.getGender());
                    patientToBeUpdate.setAddress(patient.getAddress());
                    patientToBeUpdate.setPhonenumber(patient.getPhonenumber());
                    patientToBeUpdate.setEmail(patient.getEmail());
                    patientToBeUpdate.setPassword(patient.getPassword());
                    patientRepo.save(patientToBeUpdate);
                });
                return "Patient record updated.";
            } catch (Exception e) {
                throw e;
            }
        } else {
            return "Patient does not exists in the database.";
        }
    }

    /*
    Remove patient from the database
    */
    @Transactional
    public String deletePatient(Patient patient) {
        if (patientRepo.existsById(patient.getId())) {
            try {
                Optional<Patient> patients = patientRepo.findById(patient.getId());
                patients.stream().forEach(s -> {
                    patientRepo.delete(s);
                });
                return "Patient record deleted successfully.";
            } catch (Exception e) {
                throw e;
            }

        } else {
            return "Patient does not exist";
        }
    }
    
    /*
     * Find patient in the database by email and password
     */
    @Transactional
    public String findPatient(Patient patient) {
        try {
            if (patientRepo.existsByEmail(patient.getEmail()) && patientRepo.existsByPassword(patient.getPassword())) {
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
    public String retrieveId(Patient patient) {
        if (patientRepo.existsByEmail(patient.getEmail()) && patientRepo.existsByPassword(patient.getPassword())) {
            try {
                // If the patient exists in the database
                int id = patientRepo.findByEmailPassword(patient.getEmail(), patient.getPassword());
                return "" + id;
                
            } catch (Exception e) {
                throw e;
            }
        } else {
            return "Patient not in database, try again.";
        }
    }

}
