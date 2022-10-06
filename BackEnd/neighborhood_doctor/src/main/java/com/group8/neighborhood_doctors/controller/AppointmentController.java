package com.group8.neighborhood_doctors.controller;

import com.group8.neighborhood_doctors.appointment.Appointment;

import com.group8.neighborhood_doctors.service.AppointmentService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/*
    ==============================
        Appointment Controller
    ==============================
*/

@RestController
public class AppointmentController {

    @Autowired
    private AppointmentService appointmentService;

    /*
     * [POST] Create Appointment
     */
    @RequestMapping(value = "appointment/createAppointment", method = RequestMethod.POST)
    public String createAppointment(@RequestBody Appointment appointment){
        return appointmentService.createAppointment(appointment);
    }

    /*
     * [GET] Read Appointments
     */
    @RequestMapping(value = "appointment/readAppointments", method = RequestMethod.GET)
    public List<Appointment> readAppointments(){
        return appointmentService.readAppointments();
    }

    /*
     * [PUT] Update Appointment
     * When updating, the id of the appointment must be provided
     */
    @RequestMapping(value = "appointment/updateAppointment", method = RequestMethod.PUT)
    public String updateAppointment(@RequestBody Appointment appointment){
        return appointmentService.updateAppointment(appointment);
    }

    /*
     * [DELETE] Delete Appointment
     * Only id is needed to delete an appointment
     */
    @RequestMapping(value = "appointment/deleteAppointment", method = RequestMethod.DELETE)
    public String deleteAppointment(@RequestBody Appointment appointment){
        return appointmentService.deleteAppointment(appointment);
    }
}
