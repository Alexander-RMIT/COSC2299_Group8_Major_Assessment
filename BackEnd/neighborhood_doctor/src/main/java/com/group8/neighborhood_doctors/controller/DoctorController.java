package com.group8.neighborhood_doctors.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import com.group8.neighborhood_doctors.doctor.Doctor;
import com.group8.neighborhood_doctors.jwt.JwtUtility;

import com.group8.neighborhood_doctors.service.DoctorService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import static com.group8.neighborhood_doctors.jwt.SecurityConstant.TOKEN_PREFIX;
// import org.json.simple.JSONObject;

/*
    =========================
        Doctor Controller
    =========================
*/

/*
    Can use the following format in Postman as JSON
    {
        "firstname":"",
        "lastname":"",
        "email":"",
        "password":""
    }
*/

@RestController
public class DoctorController {
    private static final Logger logger = LogManager.getLogger(DoctorController.class);

    @Autowired
    private DoctorService doctorService;

    /*
     * [POST] Create Doctor
     */
    @RequestMapping(value = "doctor/createDoctor", method = RequestMethod.POST)
    public String createDoctor(@RequestBody Doctor doctor) {
        logger.info("Creating a new doctor");
        return doctorService.createDoctor(doctor);
    }

    /*
     * [GET] Read Doctors
     */
    @RequestMapping(value = "doctor/readDoctors", method = RequestMethod.GET)
    public List<Doctor> readDoctors() {
        logger.info("Reading all doctors");
        return doctorService.readDoctors();
    }

    /*
     * [PUT] Update Doctor
     * When updating, the id of the doctor must be provided
     */
    @RequestMapping(value = "doctor/updateDoctor", method = RequestMethod.PUT)
    public String updateDoctor(@RequestBody Doctor doctor) {
        logger.info("Updating a doctor");
        return doctorService.updateDoctor(doctor);
    }

    /*
     * [DELETE] Delete Doctor
     * Only id is needed to delete a doctor
     */
    @RequestMapping(value = "doctor/deleteDoctor", method = RequestMethod.DELETE)
    public String deleteDoctor(@RequestBody Doctor doctor) {
        logger.info("Deleting a doctor");
        return doctorService.deleteDoctor(doctor);
    }

    /*
     * [POST] Login Doctor
     */
    @RequestMapping(value = "auth/doctor/login", method = RequestMethod.POST)
    public String loginDoctor(@RequestBody Doctor doctor) {
        logger.info("Logging in a doctor using JWT Token");

        if (doctorService.findDoctor(doctor) == "Incorrect login credentials entered") {
            logger.error("Incorrect login credentials entered");
            return "Incorrect login credentials entered";
        }

        // JWT Token logging in
        Base64.Encoder encode = Base64.getEncoder();

        // Header
        // JSONObject header_raw = new JSONObject();
        HashMap<String, Object> header_raw = new HashMap<>();
        header_raw.put("alg", "HS256");
        header_raw.put("type", "auth");
        String header = encode.encodeToString(header_raw.toString().getBytes());

        // Payload
        // JSONObject payload_raw = new JSONObject();
        HashMap<String, Object> payload_raw = new HashMap<>();
        payload_raw.put("id", doctorService.retrieveId(doctor));
        payload_raw.put("email", doctor.getEmail());
        payload_raw.put("password", doctor.getPassword());
        String payload = encode.encodeToString(payload_raw.toString().getBytes());

        JwtUtility util = new JwtUtility();
        
        // Making token with signature
        String JWT = TOKEN_PREFIX + util.HS256(header, payload);

        return JWT;
    }

    /*
     * [POST] Get Doctor ID
     */
    @RequestMapping(value="auth/doctor/id", method=RequestMethod.POST)
    public String sessionDoctorId(@RequestBody Doctor doctor) {
        logger.info("Getting doctor id from JWT Token");
        return doctorService.retrieveId(doctor);
    }
    
    /*
     * [POST] Get Doctor First Name
     */
    @RequestMapping(value="doctor/firstname", method=RequestMethod.POST)
    public String sessionDoctorFname(@RequestBody String token) {
        logger.info("Getting doctor first name from JWT Token");
        JwtUtility util = new JwtUtility();
        
        if (util.verifyToken(token)) {
            String token_contents[] = token.split("\\.");
            Base64.Decoder decode = Base64.getDecoder();
            String payload = new String(decode.decode(token_contents[1].getBytes()));
            JsonObject json = JsonParser.parseString(payload).getAsJsonObject();
            System.out.println(json);
            int id = json.get("id").getAsInt();
            System.out.println("ID VALUE:" + id);

            System.out.println("NAME:" + doctorService.retrieveFirstName(id));
            return doctorService.retrieveFirstName(id);
        } else {
            return "";
        }
    }

    /*
     * [GET] Get Doctor Details by ID
     */
    @RequestMapping(value = "doctor/details", method = RequestMethod.GET)
    public Optional<Doctor> sessionDoctorDetails(@RequestBody Doctor doctor) throws Exception {
        logger.info("Getting doctor details by ID from JWT Token");
        return doctorService.find(doctor.getId());
    }

    @RequestMapping(value="doctor/retrieveAllDoctors", method=RequestMethod.POST)
    public String retrieveAllDoctors(@RequestBody String token) {
        logger.info("Getting all doctors from JWT Token");
        JwtUtility util = new JwtUtility();

        if (util.verifyToken(token)) {
            String doctors = doctorService.readDoctorsString();
            logger.info("Retrieving all doctors");
            return doctors;
        } else {
            logger.error("Invalid token");
            return "";
        }
    }


    @RequestMapping(value="doctor/retrieveDoctor", method=RequestMethod.GET)
    public String retrieveDoctor(@RequestBody String token, int id) {
        logger.info("Getting doctor by ID from JWT Token");
        JwtUtility util = new JwtUtility();

        if (util.verifyToken(token)) {
            String doctor = doctorService.retrieveDoctor(id);
            logger.info("Retrieving doctor by ID");
            return doctor;
        } else {
            logger.error("Invalid token");
            return "";
        }
    }
}