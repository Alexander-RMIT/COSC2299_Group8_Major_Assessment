package com.group8.neighborhood_doctors.controller;

import com.group8.neighborhood_doctors.prescription.Prescription;
import com.group8.neighborhood_doctors.jwt.JwtUtility;

import com.group8.neighborhood_doctors.service.PrescriptionService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/*
    ===============================
        Prescription Controller
    ===============================
*/

@RestController
public class PrescriptionController {

    private static final Logger logger = LogManager.getLogger(PrescriptionController.class);

    @Autowired
    private PrescriptionService prescriptionService;
        /*
     * [POST] Create Prescription
     */
    @RequestMapping(value = "prescription/createPrescription", method = RequestMethod.POST)
    public String createPrescription(@RequestBody Prescription prescription){
        logger.info("Creating a new prescription");
        return prescriptionService.createPrescription(prescription);
    }

    /*
     * [GET] Read Prescriptions
     */
    @RequestMapping(value = "prescription/readPrescriptions", method = RequestMethod.GET)
    public List<Prescription> readPrescriptions(){
        logger.info("Reading all prescriptions");
        return prescriptionService.readPrescriptions();
    }

    /*
     * [PUT] Update prescription
     * When updating, the id of the prescription must be provided
     */
    @RequestMapping(value = "prescription/updatePrescription", method = RequestMethod.PUT)
    public String updatePrescription(@RequestBody Prescription prescription){
        logger.info("Updating a prescription");
        return prescriptionService.updatePrescription(prescription);
    }

    /*
     * [DELETE] Delete Prescription
     * Only id is needed to delete a chat
     */
    @RequestMapping(value = "prescription/deletePrescription", method = RequestMethod.DELETE)
    public String deletePrescription(@RequestBody Prescription prescription){
        logger.info("Deleting a prescription");
        return prescriptionService.deletePrescription(prescription);
    }

    @RequestMapping(value="prescriptions/retrieveAllprescriptions", method=RequestMethod.POST)
    public String retrieveAllPrescriptions(@RequestBody String token) {
        logger.info("Retrieving all prescriptions using JWT Token");
        JwtUtility util = new JwtUtility();

        if (util.verifyToken(token)) {
            String prescriptions = prescriptionService.readPrescriptionsString();
            return prescriptions;
        } else {
            logger.error("Invalid token");
            return "";
        }
    }


    @RequestMapping(value="prescription/getPrescription", method=RequestMethod.POST)
    public String retrieveAllPrescriptions(@RequestBody int prescriptionId) {
        logger.info("Retrieving all prescriptions");
        return prescriptionService.findPrescription(prescriptionId);
    }
}