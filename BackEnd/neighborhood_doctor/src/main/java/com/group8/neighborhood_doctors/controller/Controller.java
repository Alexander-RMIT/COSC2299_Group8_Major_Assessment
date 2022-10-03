package com.group8.neighborhood_doctors.controller;

import com.group8.neighborhood_doctors.administrator.Administrator;
import com.group8.neighborhood_doctors.doctor.Doctor;
import com.group8.neighborhood_doctors.patient.Patient;
import com.group8.neighborhood_doctors.appointment.Appointment;
import com.group8.neighborhood_doctors.chat.Chat;
import com.group8.neighborhood_doctors.availability.Availability;
import com.group8.neighborhood_doctors.symptom.Symptom;

import com.group8.neighborhood_doctors.service.AdminService;
import com.group8.neighborhood_doctors.service.DoctorService;
import com.group8.neighborhood_doctors.service.PatientService;
import com.group8.neighborhood_doctors.service.AppointmentService;
import com.group8.neighborhood_doctors.service.ChatService;
import com.group8.neighborhood_doctors.service.AvailabilityService;
import com.group8.neighborhood_doctors.service.SymptomService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;
import java.util.ArrayList;
import java.util.Optional;


import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import com.group8.neighborhood_doctors.service.JwtUserDetailsService;

import com.group8.neighborhood_doctors.jwt.JwtTokenUtil;
import com.group8.neighborhood_doctors.jwt.JwtRequest;
import com.group8.neighborhood_doctors.jwt.JwtResponse;

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
    
    @Autowired
    private ChatService chatService;

    @Autowired
    private AvailabilityService availabilityService;

    @Autowired
    private SymptomService symptomService;
    
    
    // ~JWT Tokenisation~
    @Autowired
	private AuthenticationManager authenticationManager;

	@Autowired
	private JwtTokenUtil jwtTokenUtil;

	@Autowired
	private JwtUserDetailsService userDetailsService;
    // ~=============================================~

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

    @RequestMapping(value = "auth/admin/login", method = RequestMethod.POST)
    public String loginAdmin(@RequestBody Administrator admin) {
        return adminService.findAdmin(admin);
    }
    
    @RequestMapping(value="auth/admin/id", method=RequestMethod.POST)
    public String sessionAdminId(@RequestBody Administrator admin) {
        return adminService.retrieveId(admin);
    }
    
    // Retrieving username of admin
    @RequestMapping(value="admin/username", method=RequestMethod.POST)
    public String sessionAdminFname(@RequestBody Administrator admin) {
        return adminService.retrieveUsername(admin);
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

    @RequestMapping(value = "auth/doctor/login", method = RequestMethod.POST)
    public String loginDoctor(@RequestBody Doctor doctor) {
        return doctorService.findDoctor(doctor);
    }
    
    @RequestMapping(value="auth/doctor/id", method=RequestMethod.POST)
    public String sessionDoctorId(@RequestBody Doctor doctor) {
        return doctorService.retrieveId(doctor);
    }
    
    // Retrieving first name of doctor
    @RequestMapping(value="doctor/firstname", method=RequestMethod.POST)
    public String sessionDoctorFname(@RequestBody Doctor doctor) {
        return doctorService.retrieveFirstName(doctor);
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

    // Authentication process for login
    @RequestMapping(value = "auth/patient/login", method = RequestMethod.POST)
    public String login(@RequestBody Patient patient) {
        return patientService.findPatient(patient);
    }
    
    // Retrieving id for user given pw and un
    @RequestMapping(value="auth/patient/id", method=RequestMethod.POST)
    public String sessionPatientId(@RequestBody Patient patient) {
        return patientService.retrieveId(patient);
    }
    
    // Retrieving first name of patient
    @RequestMapping(value="patient/firstname", method=RequestMethod.POST)
    public String sessionPatientFname(@RequestBody Patient patient) {
        return patientService.retrieveFirstName(patient);
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

    /*
    ===============================
    Chat controller 
    ===============================
    */

    @RequestMapping(value = "chat/createChat", method = RequestMethod.POST)
    public String createChat(@RequestBody Chat chat){
        return chatService.createChat(chat);
    }

    @RequestMapping(value = "chat/readChats", method = RequestMethod.GET)
    public List<Chat> readChats(){
        return chatService.readChats();
    }

    // Only id is needed to delete a chat
    @RequestMapping(value = "chat/deleteChat", method = RequestMethod.DELETE)
    public String deleteChat(@RequestBody Chat chat){
        return chatService.deleteChat(chat);
    }

    /*
    ===============================
    Availability controller 
    ===============================
    */

    @RequestMapping(value = "availability/createAvailability", method = RequestMethod.POST)
    public String createAvailability(@RequestBody Availability availability){
        return availabilityService.createAvailability(availability);
    }

    @RequestMapping(value = "availability/readAvailabilities", method = RequestMethod.GET)
    public List<Availability> readAvailabilities(){
        return availabilityService.readAvailabilities();
    }

    // When updating, the id of the availability must be provided
    @RequestMapping(value = "availability/updateAvailability", method = RequestMethod.PUT)
    public String updateAvailability(@RequestBody Availability availability){
        return availabilityService.updateAvailability(availability);
    }

    // Only id is needed to delete an availability
    @RequestMapping(value = "availability/deleteAvailability", method = RequestMethod.DELETE)
    public String deleteAvailability(@RequestBody Availability availability){
        return availabilityService.deleteAvailability(availability);
    }

    /*
    ===============================
    Symptom controller 
    ===============================
    */

    @RequestMapping(value = "symptom/createSymptom", method = RequestMethod.POST)
    public String createSymptom(@RequestBody Symptom symptom){
        return symptomService.createSymptom(symptom);
    }

    @RequestMapping(value = "symptom/readSymptoms", method = RequestMethod.GET)
    public List<Symptom> readSymptoms(){
        return symptomService.readSymptoms();
    }

    // When updating, the id of the symptom must be provided
    @RequestMapping(value = "symptom/updateSymptom", method = RequestMethod.PUT)
    public String updateSymptom(@RequestBody Symptom symptom){
        return symptomService.updateSymptom(symptom);
    }

    // Only id is needed to delete a chat
    @RequestMapping(value = "symptom/deleteSymptom", method = RequestMethod.DELETE)
    public String deleteSymptom(@RequestBody Symptom symptom){
        return symptomService.deleteSymptom(symptom);
    }

    @RequestMapping(value = "symptom/retrieveSymtomName", method = RequestMethod.POST)
    public List<Symptom> retrieveSymtomName(@RequestBody Symptom symptom){
        return symptomService.retrieveSymtomName(symptom);
    }
    
    
    // ~JWT Tokenisation~
    @RequestMapping(value = "/authenticate", method = RequestMethod.POST)
	public ResponseEntity<?> createAuthenticationToken(@RequestBody JwtRequest authenticationRequest) throws Exception {

		authenticate(authenticationRequest.getUsername(), authenticationRequest.getPassword());

		final UserDetails userDetails = userDetailsService
				.loadUserByUsername(authenticationRequest.getUsername());

		final String token = jwtTokenUtil.generateToken(userDetails);

		return ResponseEntity.ok(new JwtResponse(token));
	}

	private void authenticate(String username, String password) throws Exception {
		try {
			authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
		} catch (DisabledException e) {
			throw new Exception("USER_DISABLED", e);
		} catch (BadCredentialsException e) {
			throw new Exception("INVALID_CREDENTIALS", e);
		}
	}
    // <>=================================<>
    
}
