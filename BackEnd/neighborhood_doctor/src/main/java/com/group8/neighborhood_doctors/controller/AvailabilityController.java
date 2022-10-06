package com.group8.neighborhood_doctors.controller;

import com.group8.neighborhood_doctors.availability.Availability;

import com.group8.neighborhood_doctors.service.AvailabilityService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/*
    ===============================
        Availability Controller
    ===============================
*/

@RestController
public class AvailabilityController {

    @Autowired
    private AvailabilityService availabilityService;

    /*
     * [POST] Create Availability
     */
    @RequestMapping(value = "availability/createAvailability", method = RequestMethod.POST)
    public String createAvailability(@RequestBody Availability availability){
        return availabilityService.createAvailability(availability);
    }

    /*
     * [GET] Read Availabilities
     */
    @RequestMapping(value = "availability/readAvailabilities", method = RequestMethod.GET)
    public List<Availability> readAvailabilities(){
        return availabilityService.readAvailabilities();
    }

    /*
     * [PUT] Update Availability
     * When updating, the id of the availability must be provided
     */
    @RequestMapping(value = "availability/updateAvailability", method = RequestMethod.PUT)
    public String updateAvailability(@RequestBody Availability availability){
        return availabilityService.updateAvailability(availability);
    }

    /*
     * [DELETE] Delete Availability
     * Only id is needed to delete an availability
     */
    @RequestMapping(value = "availability/deleteAvailability", method = RequestMethod.DELETE)
    public String deleteAvailability(@RequestBody Availability availability){
        return availabilityService.deleteAvailability(availability);
    }
}
