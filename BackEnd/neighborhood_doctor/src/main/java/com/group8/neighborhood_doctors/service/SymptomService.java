package com.group8.neighborhood_doctors.service;

import com.group8.neighborhood_doctors.symptom.Symptom;
import com.group8.neighborhood_doctors.repository.SymptomRepo;
import com.group8.neighborhood_doctors.repository.PatientRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.io.Console;
import java.util.HashMap;

import com.google.gson.Gson;
@Service
public class SymptomService {
    @Autowired
    private SymptomRepo symptomRepo;

    @Autowired
    private PatientRepo patientRepo;

    @Transactional
    public String createSymptom(Symptom symptom){
        try {
            // Check if the patient exists in the database
            if (patientRepo.existsById(symptom.getPatientId())) {
                // If patient already have a symptom, then the symptom already exists for the patient
                if (!(symptomRepo.existsByPatientId(symptom.getPatientId()) && symptomRepo.existsByName(symptom.getName()))) {
                    symptom.setId(null == symptomRepo.findMaxId()? 1 : symptomRepo.findMaxId() + 1);
                    symptomRepo.save(symptom);
                    return "[SUCCESS] New symptom record created successfully.";
                } else {
                    return "[FAILED] Reason: Symptom already exists in the database.";
                }
            } else {
                return "[FAILED] Reason: Patient does not exist in the database.";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public List<Symptom> readSymptoms() {
        return symptomRepo.findAll();
    }

    /*
     * Can update the symptom name, serverity, and note
     */
    @Transactional
    public String updateSymptom(Symptom symptom) {

        // Updating Patient Symptom, check if the patient has a symptom
        // Do not have to check if the patient exists in the database in updateSymptom
        // Because when patient add an new symptom, the program MUST check if the patient exists in the database
                Symptom symptomToBeUpdate = symptomRepo.findById(symptom.getId()).get();
                symptomToBeUpdate.setName(symptom.getName());
                symptomToBeUpdate.setSeverity(symptom.getSeverity());
                symptomToBeUpdate.setNote(symptom.getNote());
                symptomRepo.save(symptomToBeUpdate);
                return "[SUCCESS] Symptom record updated.";
    }

    @Transactional
    public String deleteSymptom(Symptom symptom) {

        // Deleting Patient Symptom, check if the patient has a symptom
        // Do not have to check if the patient exists in the database in deleteSymptom
        // Because when patient add an new symptom, the program MUST check if the patient exists in the database
        if (symptomRepo.existsByPatientId(symptom.getPatientId())) {
            try {
                Optional<Symptom> symptoms = symptomRepo.findByPatientId(symptom.getPatientId());
                symptoms.stream().forEach(s -> {
                    symptomRepo.delete(s);
                });
                return "[SUCCESS] Symptom record deleted successfully.";
            } catch (Exception e) {
                throw e;
            }

        } else {
            return "[FAILED] Reason: Symptom does not exist";
        }
    }

    // Retrieve symptom name by patient id
    @Transactional
    public List<Symptom> retrieveSymtomName(Symptom symptom) {
        try {
            return symptomRepo.findNameByPatientId(symptom.getPatientId());
        } catch (Exception e) {
            throw e;
        }
    }

    public String readSymptomsString() {
        List<Symptom> symptoms = symptomRepo.findAll();
        // firstname    lastname    name/other  gender  age DoB
        String strSymptoms = "[";

        for (int i = 0; i < symptoms.size(); i++) {
            Symptom curSymptom = symptoms.get(i);
            // Format to be a map
            Map<String, Object> map = new HashMap<>();
            map.put("id", curSymptom.getId());
            map.put("name", curSymptom.getName());
            map.put("patientId", curSymptom.getPatientId());
            map.put("severity", curSymptom.getSeverity());
            map.put("note", curSymptom.getNote());
            Gson gson = new Gson();
            String json = gson.toJson(map);


            strSymptoms += json;

            if (i != symptoms.size() - 1) {
                strSymptoms += ", ";
            }

        }
        strSymptoms += "]";

        return strSymptoms;
    }

    public String findSymptom(int id) {
            return symptomRepo.findSymptomById(id).toString(); 
    }}
