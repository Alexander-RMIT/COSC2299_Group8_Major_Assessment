package com.group8.neighborhood_doctors.controller;

import com.group8.neighborhood_doctors.entity.administrator;
import com.group8.neighborhood_doctors.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
public class Controller {

    @Autowired
    private AdminService adminService;
    
    @RequestMapping(value = "info", method = RequestMethod.GET)
    public String info() {
        return "The application is up...";
    }

    @RequestMapping(value = "createAdmin", method = RequestMethod.POST)
    public String createStudent(@RequestBody administrator admin){
        return adminService.createAdmin(admin);
    }

    @RequestMapping(value = "readAdmins", method = RequestMethod.GET)
    public List<administrator> readAdmins(){
        return adminService.readAdmins();
    }

    @RequestMapping(value = "updateAdmin", method = RequestMethod.PUT)
    public String updateAdmin(@RequestBody administrator admin){
        return adminService.updateAdmin(admin);
    }

    @RequestMapping(value = "deleteAdmin", method = RequestMethod.DELETE)
    public String deleteAdmin(@RequestBody administrator admin){
        return adminService.deleteAdmin(admin);
    }
}
