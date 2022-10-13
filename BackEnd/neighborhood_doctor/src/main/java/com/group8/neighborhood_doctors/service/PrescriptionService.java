package com.group8.neighborhood_doctors.service;

import com.group8.neighborhood_doctors.prescription.Prescription;
import com.group8.neighborhood_doctors.repository.PrescriptionRepo;
import com.group8.neighborhood_doctors.repository.PatientRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.HashMap;

import com.google.gson.Gson;
@Service
public class PrescriptionService {
    @Autowired
    private PrescriptionRepo prescriptionRepo;

    @Autowired
    private PatientRepo patientRepo;

    @Transactional
    public String createPrescription(Prescription prescription){
        try {
            // Check if the patient exists in the database
            if (patientRepo.existsById(prescription.getPatientId())) {
                // If patient already have a prescription, then the prescription already exists for the patient
                if (!(prescriptionRepo.existsByPatientId(prescription.getPatientId()) && prescriptionRepo.existsBymedicationId(prescription.getMedicationId()))) {
                    prescription.setId(null == prescriptionRepo.findMaxId()? 1 : prescriptionRepo.findMaxId() + 1);
                    prescriptionRepo.save(prescription);
                    return "[SUCCESS] New prescription record created successfully.";
                } else {
                    return "[FAILED] Reason: Prescription already exists in the database.";
                }
            } else {
                return "[FAILED] Reason: Patient does not exist in the database.";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public List<Prescription> readPrescriptions() {
        return prescriptionRepo.findAll();
    }

    /*
     * Can update the prescription name, serverity, and note
     */
    @Transactional
    public String updatePrescription(Prescription prescription) {

        // Updating Patient Prescription, check if the patient has a prescription
        // Do not have to check if the patient exists in the database in updatePrescription
        // Because when patient add an new prescription, the program MUST check if the patient exists in the database
        Prescription prescriptionToBeUpdate = prescriptionRepo.findById(prescription.getId()).get();
        prescriptionToBeUpdate.setDate(prescription.getDate());
        prescriptionToBeUpdate.setDescription(prescription.getDescription());
        prescriptionToBeUpdate.setMedicationId(prescription.getMedicationId());
        prescriptionToBeUpdate.setName(prescription.getName());
        prescriptionRepo.save(prescriptionToBeUpdate);
        return "[SUCCESS] Prescription record updated.";
    }

    @Transactional
    public String deletePrescription(Prescription prescription) {

        // Deleting Patient Prescription, check if the patient has a prescription
        // Do not have to check if the patient exists in the database in deletePrescription
        // Because when patient add an new prescription, the program MUST check if the patient exists in the database
        if (prescriptionRepo.existsByPatientId(prescription.getPatientId())) {
            try {
                Optional<Prescription> prescriptions = prescriptionRepo.findByPatientId(prescription.getPatientId());
                prescriptions.stream().forEach(s -> {
                    prescriptionRepo.delete(s);
                });
                return "[SUCCESS] Prescription record deleted successfully.";
            } catch (Exception e) {
                throw e;
            }

        } else {
            return "[FAILED] Reason: Prescription does not exist";
        }
    }


    public String readPrescriptionsString() {
        List<Prescription> prescriptions = prescriptionRepo.findAll();
        // firstname    lastname    name/other  gender  age DoB
        String strPrescriptions = "[";

        for (int i = 0; i < prescriptions.size(); i++) {
            Prescription curPrescription = prescriptions.get(i);
            // Format to be a map
            Map<String, Object> map = new HashMap<>();
            map.put("id", curPrescription.getId());
            map.put("patientId", curPrescription.getPatientId());
            map.put("medicationId", curPrescription.getMedicationId());
            map.put("date", curPrescription.getDate());
            map.put("description", curPrescription.getDescription());
            map.put("name", curPrescription.getName());
            Gson gson = new Gson();
            String json = gson.toJson(map);


            strPrescriptions += json;

            if (i != prescriptions.size() - 1) {
                strPrescriptions += ", ";
            }

        }
        strPrescriptions += "]";

        return strPrescriptions;
    }

    public String findPrescription(int id) {
        return prescriptionRepo.findPrescriptionById(id).toString();
    }}
