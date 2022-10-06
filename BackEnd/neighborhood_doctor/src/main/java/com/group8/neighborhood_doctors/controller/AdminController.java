package com.group8.neighborhood_doctors.controller;

import com.group8.neighborhood_doctors.administrator.Administrator;

import com.group8.neighborhood_doctors.service.AdminService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

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

    @Autowired
    private AdminService adminService;

    /*
     * [POST] Create Administrator
     */
    @RequestMapping(value = "admin/createAdmin", method = RequestMethod.POST)
    public String createAdmin(@RequestBody Administrator admin) {
        return adminService.createAdmin(admin);
    }

    /*
     * [GET] Read Administrators
     */
    @RequestMapping(value = "admin/readAdmins", method = RequestMethod.GET)
    public List<Administrator> readAdmins() {
        return adminService.readAdmins();
    }

    /*
     * [PUT] Update Administrator
     * When updating, the id of the admin must be provided
     */
    @RequestMapping(value = "admin/updateAdmin", method = RequestMethod.PUT)
    public String updateAdmin(@RequestBody Administrator admin) {
        return adminService.updateAdmin(admin);
    }

    /*
     * [DELETE] Delete Administrator
     * Only id is needed to delete an admin
     */
    @RequestMapping(value = "admin/deleteAdmin", method = RequestMethod.DELETE)
    public String deleteAdmin(@RequestBody Administrator admin) {
        return adminService.deleteAdmin(admin);
    }

    /*
     * [POST] Login Administrator
     */
    @RequestMapping(value = "auth/admin/login", method = RequestMethod.POST)
    public String loginAdmin(@RequestBody Administrator admin) {
        return adminService.findAdmin(admin);
    }

    /*
     * [POST] Get Administrator ID
     */
    @RequestMapping(value = "auth/admin/id", method = RequestMethod.POST)
    public String sessionAdminId(@RequestBody Administrator admin) {
        return adminService.retrieveId(admin);
    }

    /*
     * [POST] Get Administrator Username
     */
    @RequestMapping(value = "admin/username", method = RequestMethod.POST)
    public String sessionAdminFname(@RequestBody int id) {
        return adminService.retrieveUsername(id);
    }
}
