package com.group8.neighborhood_doctors.controller;

import com.group8.neighborhood_doctors.symptom.Symptom;
import com.group8.neighborhood_doctors.jwt.JwtUtility;

import com.group8.neighborhood_doctors.service.SymptomService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/*
    ==========================
        Symptom Controller
    ==========================
*/

@RestController
public class SymptomController {

    @Autowired
    private SymptomService symptomService;

    /*
     * [POST] Create Symptom
     */
    @RequestMapping(value = "symptom/createSymptom", method = RequestMethod.POST)
    public String createSymptom(@RequestBody Symptom symptom){
        return symptomService.createSymptom(symptom);
    }

    /*
     * [GET] Read Symptoms
     */
    @RequestMapping(value = "symptom/readSymptoms", method = RequestMethod.GET)
    public List<Symptom> readSymptoms(){
        return symptomService.readSymptoms();
    }

    /*
     * [PUT] Update Symptom
     * When updating, the id of the symptom must be provided
     */
    @RequestMapping(value = "symptom/updateSymptom", method = RequestMethod.PUT)
    public String updateSymptom(@RequestBody Symptom symptom){
        return symptomService.updateSymptom(symptom);
    }

    /*
     * [DELETE] Delete Symptom
     * Only id is needed to delete a chat
     */
    @RequestMapping(value = "symptom/deleteSymptom", method = RequestMethod.DELETE)
    public String deleteSymptom(@RequestBody Symptom symptom){
        return symptomService.deleteSymptom(symptom);
    }

    /*
     * [POST] Get Symptom Name
     */
    @RequestMapping(value = "symptom/retrieveSymtomName", method = RequestMethod.POST)
    public List<Symptom> retrieveSymtomName(@RequestBody Symptom symptom){
        return symptomService.retrieveSymtomName(symptom);
    }

    @RequestMapping(value="symptoms/retrieveAllSymptoms", method=RequestMethod.POST)
    public String retrieveAllSymptoms(@RequestBody String token) {
        JwtUtility util = new JwtUtility();

        if (util.verifyToken(token)) {
            String symptoms = symptomService.readSymptomsString();
            return symptoms;
        } else {
            return "";
        }
    }


    @RequestMapping(value="symptom/getSymptom", method=RequestMethod.POST)
    public String retrieveAllSymptoms(@RequestBody int symptomId) {
        return symptomService.findSymptom(symptomId);
    }
    
    }

