package com.group8.neighborhood_doctors.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import com.group8.neighborhood_doctors.administrator.Administrator;
import com.group8.neighborhood_doctors.jwt.JwtUtility;

import com.group8.neighborhood_doctors.service.AdminService;

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
    ================================
        Administrator Controller
    ================================
*/

/*
    Can use the following format in Postman as JSON
    {
        "username": "",
        "password": ""
    }
*/

@RestController
public class AdminController {

    private static final Logger logger = LogManager.getLogger(AdminController.class);

    @Autowired
    private AdminService adminService;

    /*
     * [POST] Create Administrator
     */
    @RequestMapping(value = "admin/createAdmin", method = RequestMethod.POST)
    public String createAdmin(@RequestBody Administrator admin) {
        logger.info("Creating a new administrator");
        return adminService.createAdmin(admin);
    }

    /*
     * [GET] Read Administrators
     */
    @RequestMapping(value = "admin/readAdmins", method = RequestMethod.GET)
    public List<Administrator> readAdmins() {
        logger.info("Reading all administrators");
        return adminService.readAdmins();
    }

    /*
     * [PUT] Update Administrator
     * When updating, the id of the admin must be provided
     */
    @RequestMapping(value = "admin/updateAdmin", method = RequestMethod.PUT)
    public String updateAdmin(@RequestBody Administrator admin) {
        logger.info("Updating information for a given administrators");
        return adminService.updateAdmin(admin);
    }

    /*
     * [DELETE] Delete Administrator
     * Only id is needed to delete an admin
     */
    @RequestMapping(value = "admin/deleteAdmin", method = RequestMethod.DELETE)
    public String deleteAdmin(@RequestBody Administrator admin) {
        logger.info("Deleting a given administrator");
        return adminService.deleteAdmin(admin);
    }

    /*
     * [POST] Login Administrator
     */
    @RequestMapping(value = "auth/admin/login", method = RequestMethod.POST)
    public String loginAdmin(@RequestBody Administrator admin) {
        logger.info("Logging in an administrator using JWT Token");

        if (adminService.findAdmin(admin) == "Incorrect login credentials entered") {
            logger.error("Incorrect login credentials entered");
            return "Incorrect login credentials entered";
        }

        // JWT Token logging in
        Base64.Encoder encode = Base64.getEncoder();

        // Header
        // JSONObject header_raw = new JSONObject();
        HashMap<String,Object> header_raw = new HashMap<String,Object>();
        header_raw.put("alg", "HS256");
        header_raw.put("type", "auth");
        String header = encode.encodeToString(header_raw.toString().getBytes());

        // Payload
        // JSONObject payload_raw = new JSONObject();
        HashMap<String,Object> payload_raw = new HashMap<String,Object>();
        payload_raw.put("id", adminService.retrieveId(admin));
        payload_raw.put("email", admin.getEmail());
        payload_raw.put("password", admin.getPassword());
        String payload = encode.encodeToString(payload_raw.toString().getBytes());

        JwtUtility util = new JwtUtility();
        
        // Making token with signature
        String JWT = TOKEN_PREFIX + util.HS256(header, payload);

        return JWT;
    }

    /*
     * [POST] Get Administrator ID
     */
    @RequestMapping(value = "auth/admin/id", method = RequestMethod.POST)
    public String sessionAdminId(@RequestBody Administrator admin) {
        logger.info("Retriving the ID of an administrator using JWT Token");
        return adminService.retrieveId(admin);
    }

    /*
     * [POST] Get Administrator Username
     */
    @RequestMapping(value = "admin/username", method = RequestMethod.POST)
    public String sessionAdminFname(@RequestBody String token) {
        logger.info("Retriving the username of an administrator using JWT Token");
        JwtUtility util = new JwtUtility();
        
        if (util.verifyToken(token)) {
            String token_contents[] = token.split("\\.");
            Base64.Decoder decode = Base64.getDecoder();
            String payload = new String(decode.decode(token_contents[1].getBytes()));
            JsonObject json = JsonParser.parseString(payload).getAsJsonObject();
            System.out.println(json);
            int id = json.get("id").getAsInt();
            System.out.println("ID VALUE:" + id);

            System.out.println("NAME:" + adminService.retrieveUsername(id));
            return adminService.retrieveUsername(id);
        } else {
            return "";
        }
    }

    @RequestMapping(value="admin/retrieveAllAdmins", method=RequestMethod.POST)
    public String retrieveAllAdmins(@RequestBody String token) {
        logger.info("Retriving the all admins using JWT Token");
        JwtUtility util = new JwtUtility();

        if (util.verifyToken(token)) {
            String admins = adminService.readAdminsString();
            return admins;
        } else {
            return "";
        }
    }


    @RequestMapping(value="admin/retrieveAdmin", method=RequestMethod.GET)
    public String retrieveAdmin(@RequestBody String token, int id) {
        logger.info("Retriving the admin by id: {" + id + "} using JWT Token");
        JwtUtility util = new JwtUtility();

        if (util.verifyToken(token)) {
            String admin = adminService.retrieveAdmin(id);
            return admin;
        } else {
            return "";
        }
    }

    /*
     * [GET] Get Administrator Details by ID
     */
    @RequestMapping(value = "admin/details", method = RequestMethod.GET)
    public Optional<Administrator> sessionAdminDetails(@RequestBody Administrator administrator) throws Exception {
        try {
            logger.info("Retriving the admin by id: {" + administrator.getId() + "}");
            return adminService.find(administrator.getId());
        } catch (Exception e) {
            logger.error("Error: " + e);
            throw new Exception("Error: " + e);
        }
    }
}