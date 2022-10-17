package com.group8.neighborhood_doctors.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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

    final Logger logger = LogManager.getLogger(StatusController.class);

    /*
     * [GET] Check if the server is running
     */
    @RequestMapping(value = "info", method = RequestMethod.GET)
    public String info() {
        logger.info("A request was made to check if the server is running");
        return "The database is working normally!";
    }
}
