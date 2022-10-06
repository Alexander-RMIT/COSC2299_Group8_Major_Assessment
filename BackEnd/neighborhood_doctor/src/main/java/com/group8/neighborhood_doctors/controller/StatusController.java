package com.group8.neighborhood_doctors.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/*
    =========================
        Status Controller
    =========================
*/
@RestController
public class StatusController {

    /*
     * [GET] Check if the server is running
     */
    @RequestMapping(value = "info", method = RequestMethod.GET)
    public String info() {
        return "The database is working normally!";
    }
}
