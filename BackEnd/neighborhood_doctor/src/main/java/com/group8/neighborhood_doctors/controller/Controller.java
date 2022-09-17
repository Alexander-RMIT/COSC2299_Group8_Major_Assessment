package com.group8.neighborhood_doctors.controller;

import com.group8.neighborhood_doctors.administrator.Administrator;
import com.group8.neighborhood_doctors.doctor.Doctor;
import com.group8.neighborhood_doctors.patient.Patient;
import com.group8.neighborhood_doctors.appointment.Appointment;

import com.group8.neighborhood_doctors.service.AdminService;
import com.group8.neighborhood_doctors.service.DoctorService;
import com.group8.neighborhood_doctors.service.PatientService;
import com.group8.neighborhood_doctors.service.AppointmentService;

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
    
    @Autowired
    private DoctorService doctorService;

    @Autowired
    private PatientService patientService;

    @Autowired
    private AppointmentService appointmentService;

    /*
    ===============================
    Check database connection info
    ===============================
    */

    @RequestMapping(value = "info", method = RequestMethod.GET)
    public String info() {
        return "The database is working normally!";
    }
    
    /*
    ===============================
    Administrator controller 
    ===============================
    */

    /*
    Can use the format below in Postman as JSON
    {
        "username":"",
        "password":""
    }
    */
    @RequestMapping(value = "admin/createAdmin", method = RequestMethod.POST)
    public String createAdmin(@RequestBody Administrator admin){
        return adminService.createAdmin(admin);
    }

    @RequestMapping(value = "admin/readAdmins", method = RequestMethod.GET)
    public List<Administrator> readAdmins(){
        return adminService.readAdmins();
    }

    // When updating, the id of the admin must be provided
    @RequestMapping(value = "admin/updateAdmin", method = RequestMethod.PUT)
    public String updateAdmin(@RequestBody Administrator admin){
        return adminService.updateAdmin(admin);
    }

    // Only id is needed to delete an admin
    @RequestMapping(value = "admin/deleteAdmin", method = RequestMethod.DELETE)
    public String deleteAdmin(@RequestBody Administrator admin){
        return adminService.deleteAdmin(admin);
    }

    /*
    ===============================
    Doctor controller 
    ===============================
    */

    /*
    Can use the format below in Postman as JSON
    {
        "firstname":"",
        "lastname":"",
        "email":"",
        "password":""
    }
    */
    @RequestMapping(value = "doctor/createDoctor", method = RequestMethod.POST)
    public String createDoctor(@RequestBody Doctor doctor){
        return doctorService.createDoctor(doctor);
    }

    @RequestMapping(value = "doctor/readDoctors", method = RequestMethod.GET)
    public List<Doctor> readDoctors(){
        return doctorService.readDoctors();
    }

    // When updating, the id of the doctor must be provided
    @RequestMapping(value = "doctor/updateDoctor", method = RequestMethod.PUT)
    public String updateDoctor(@RequestBody Doctor doctor){
        return doctorService.updateDoctor(doctor);
    }

    // Only id is needed to delete a doctor
    @RequestMapping(value = "doctor/deleteDoctor", method = RequestMethod.DELETE)
    public String deleteDoctor(@RequestBody Doctor doctor){
        return doctorService.deleteDoctor(doctor);
    }

    /*
    ===============================
    Patient controller 
    ===============================
    */

    /*
    Can use the format below in Postman as JSON
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
    @RequestMapping(value = "patient/createPatient", method = RequestMethod.POST)
    public String createPatient(@RequestBody Patient patient){
        return patientService.createPatient(patient);
    }

    @RequestMapping(value = "patient/readPatients", method = RequestMethod.GET)
    public List<Patient> readPatients(){
        return patientService.readPatients();
    }

    // When updating, the id of the patient must be provided
    @RequestMapping(value = "patient/updatePatient", method = RequestMethod.PUT)
    public String updatePatient(@RequestBody Patient patient){
        return patientService.updatePatient(patient);
    }

    // Only id is needed to delete a patient
    @RequestMapping(value = "patient/deletePatient", method = RequestMethod.DELETE)
    public String deletePatient(@RequestBody Patient patient){
        return patientService.deletePatient(patient);
    }

    /*
    ===============================
    Appointment controller 
    ===============================
    */

    @RequestMapping(value = "appointment/createAppointment", method = RequestMethod.POST)
    public String createAppointment(@RequestBody Appointment appointment){
        return appointmentService.createAppointment(appointment);
    }

    @RequestMapping(value = "appointment/readAppointments", method = RequestMethod.GET)
    public List<Appointment> readAppointments(){
        return appointmentService.readAppointments();
    }

    // When updating, the id of the appointment must be provided
    @RequestMapping(value = "appointment/updateAppointment", method = RequestMethod.PUT)
    public String updateAppointment(@RequestBody Appointment appointment){
        return appointmentService.updateAppointment(appointment);
    }

    // Only id is needed to delete an appointment
    @RequestMapping(value = "appointment/deleteAppointment", method = RequestMethod.DELETE)
    public String deleteAppointment(@RequestBody Appointment appointment){
        return appointmentService.deleteAppointment(appointment);
    }
    
    
    
    // Authentication process for login
    @RequestMapping(value = "auth/patient/login", method = RequestMethod.POST)
    public String login(@RequestBody Patient patient) {
        return patientService.findPatient(patient);
    }

    @RequestMapping(value = "auth/doctor/login", method = RequestMethod.POST)
    public String loginDoctor(@RequestBody Doctor doctor) {
        return doctorService.findDoctor(doctor);
    }

    @RequestMapping(value = "auth/admin/login", method = RequestMethod.POST)
    public String loginAdmin(@RequestBody Administrator admin) {
        return adminService.findAdmin(admin);
    }

}
