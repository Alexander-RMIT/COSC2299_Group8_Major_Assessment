package com.group8.neighborhood_doctors.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import com.group8.neighborhood_doctors.patient.Patient;
import com.group8.neighborhood_doctors.jwt.JwtUtility;

import com.group8.neighborhood_doctors.service.PatientService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.Base64;
import java.util.List;

import static com.group8.neighborhood_doctors.jwt.SecurityConstant.TOKEN_PREFIX;
import org.json.simple.JSONObject;

/*
    ==========================
        Patient Controller
    ==========================
*/

/*
    Can use the following format in Postman as JSON
    {
        "firstname":"",
        "lastname":"",
        "nameother":"",
        "age": 1,
        "gender":"",
        "address":"",
        "phonenumber":"",
        "email":"",
        "password":""
    }
*/

@RestController
public class PatientController {

    @Autowired
    private PatientService patientService;

    /*
     * [POST] Create Patient
     */
    @RequestMapping(value = "patient/createPatient", method = RequestMethod.POST)
    public String createPatient(@RequestBody Patient patient) {
        return patientService.createPatient(patient);
    }

    /*
     * [GET] Read Patients
     */
    @RequestMapping(value = "patient/readPatients", method = RequestMethod.GET)
    public List<Patient> readPatients() {
        return patientService.readPatients();
    }

    /*
     * [PUT] Update Patient
     * When updating, the id of the patient must be provided
     */
    @RequestMapping(value = "patient/updatePatient", method = RequestMethod.PUT)
    public String updatePatient(@RequestBody Patient patient) {
        return patientService.updatePatient(patient);
    }

    /*
     * [DELETE] Delete Patient
     * Only id is needed to delete a patient
     */
    @RequestMapping(value = "patient/deletePatient", method = RequestMethod.DELETE)
    public String deletePatient(@RequestBody Patient patient) {
        return patientService.deletePatient(patient);
    }

    /*
     * [POST] Login Patient
     * Authentication process for login
     */
    @RequestMapping(value = "auth/patient/login", method = RequestMethod.POST)
    public String login(@RequestBody Patient patient) {
        // Create JWT Token: header.payload.signature
        // 1. Create the header
        // 2. Create the payload
        //      Base 64 encode email + password
        // 3. Create the signature: using the hashing algorithm specified in header
        // https://blog.logrocket.com/secure-rest-api-jwt-authentication/

        if (patientService.findPatient(patient) == "Incorrect login credentials entered") {
            return "Incorrect login credentials entered";
        }
        // JWT Token logging in
        Base64.Encoder encode = Base64.getEncoder();

        // Header
        JSONObject header_raw = new JSONObject();
        header_raw.put("alg", "HS256");
        header_raw.put("type", "auth");
        String header = encode.encodeToString(header_raw.toString().getBytes());

        // Payload
        JSONObject payload_raw = new JSONObject();
        payload_raw.put("id", patientService.retrieveId(patient));
        payload_raw.put("email", patient.getEmail());
        payload_raw.put("password", patient.getPassword());
        String payload = encode.encodeToString(payload_raw.toString().getBytes());

        JwtUtility util = new JwtUtility();
        
        // Making token with signature
        String JWT = TOKEN_PREFIX + util.HS256(header, payload);
        
        return JWT;
    }

    /*
     * [POST] Get Patient ID
     * Retrieving id for user given pw and un
     */
    @RequestMapping(value="auth/patient/id", method=RequestMethod.POST)
    public String sessionPatientId(@RequestBody Patient patient) {
        return patientService.retrieveId(patient);
    }
    
    /*
     * [POST] Get Patient ID
     * Retrieving first name of patient
     */
    @RequestMapping(value="patient/firstname", method=RequestMethod.POST)
    public String sessionPatientFname(@RequestBody String token) {
        JwtUtility util = new JwtUtility();
        if (util.verifyToken(token)) {
            String token_contents[] = token.split("\\.");
            Base64.Decoder decode = Base64.getDecoder();
            String payload = new String(decode.decode(token_contents[1].getBytes()));
            JsonObject json = JsonParser.parseString(payload).getAsJsonObject();
            System.out.println(json);
            int id = json.get("id").getAsInt();
            System.out.println("ID VALUE:" + id);

            System.out.println("NAME:" + patientService.retrieveFirstName(id));
            return patientService.retrieveFirstName(id);
        } else {
            return "";
        }
    }
    
    @RequestMapping(value="patient/retrieveAllPatients", method=RequestMethod.POST)
    public String retrieveAllPatients(@RequestBody String token) {
        JwtUtility util = new JwtUtility();

        if (util.verifyToken(token)) {
            String patients = patientService.readPatientsString();
            return patients;
        } else {
            return "";
        }
    }


    @RequestMapping(value="patient/retrievePatient", method=RequestMethod.GET)
    public String retrievePatient(@RequestBody String token, int id) {
        JwtUtility util = new JwtUtility();

        if (util.verifyToken(token)) {
            String patient = patientService.retrievePatient(id);
            return patient;
        } else {
            return "";
        }
    }
    
    
    
}
