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
                return "[SUCCESS] Patient record created successfully.";
            } else {
                return "[FAILED] Reason: Patient already exists in the database.";
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
                return "[SUCCESS] Patient record updated.";
            } catch (Exception e) {
                throw e;
            }
        } else {
            return "[FAILED] Reason: Patient does not exists in the database.";
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
                return "[SUCCESS] Patient record deleted successfully.";
            } catch (Exception e) {
                throw e;
            }

        } else {
            return "[FAILED] Reason: Patient does not exist";
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
       
    // Retrieve Patient first name by their id
    @Transactional
    public String retrieveFirstName(int id) {
        try {
            String fname = patientRepo.findNameById(id);
            return fname;
        } catch (Exception e) {
            throw e;
        }
    }
    
    /*
    Get all the patients from the database
    */
    public String readPatientsString() {
        List<Patient> patients = patientRepo.findAll();
        // firstname    lastname    name/other  gender  age DoB 
        String strPatients = "[";

        for (int i = 0; i < patients.size(); i++) {
            Patient curPatient = patients.get(i);
            // Format to be a map
            Map<String, Object> map = new HashMap<>();
            map.put("id", curPatient.getId());
            map.put("firstname", curPatient.getFirstname());
            map.put("lastname", curPatient.getLastname());
            map.put("nameother", curPatient.getNameother());
            map.put("gender", curPatient.getGender());
            map.put("age", curPatient.getAge());
            Gson gson = new Gson();
            String json = gson.toJson(map);
            

            strPatients += json;
            
            if (i != patients.size() - 1) {
                strPatients += ", ";
            }
            
        }
        strPatients += "]";

        return strPatients;
    }

    /*
     * Retrieving Patient by their id
     */
    @Transactional 
    public String retrievePatient(int id) {
        if (patientRepo.existsById(id)) {
            String patient = "[";
            Patient p = patientRepo.getById(id);

            Map<String, Object> map = new HashMap<>();
            map.put("id", p.getId());
            map.put("firstname", p.getFirstname());
            map.put("lastname", p.getLastname());
            map.put("nameother", p.getNameother());
            map.put("gender", p.getGender());
            map.put("age", p.getAge());
            map.put("address", p.getAddress());
            map.put("phonenumber", p.getPhonenumber());
            Gson gson = new Gson();
            String json = gson.toJson(map);
            
            patient += json;
            patient += "]";
            return patient;

        } else {
            return "patient not in database, try again";
        }
    }
}
