package com.group8.neighborhood_doctors.patient;

import java.util.Set;
import javax.validation.ValidatorFactory;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.*;

/*
 * This class tests the Patient class
 */

class PatientTests {

    // create a validator factory
    ValidatorFactory factory;
    // create a validator
    Validator validator;
    
    private String firstname;
    private String lastname;
    private String email;
    private String password;

    @BeforeEach
    @DisplayName("Create a validator factory and a validator")
    void setup() {
        factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    /*
     * Test if the functionality of checking if the first name is empty works
     */
    @Test
    public void whenEmptyFirstname_thenOneConstraintViolation() {
        // create a patient object
        Patient patient = new Patient();
        // set the first name to be empty
        patient.setFirstname(firstname);
        
        // validate the patient object
        Set<ConstraintViolation<Patient>> violations = validator.validate(patient);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    /*
     * Test if the functionality of checking if the last name is empty works
     */
    @Test
    public void whenEmptyLastname_thenOneConstraintViolation() {
        // create a patient object
        Patient patient = new Patient();
        // set the last name to be empty
        patient.setLastname(lastname);
        
        // validate the patient object
        Set<ConstraintViolation<Patient>> violations = validator.validate(patient);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    /*
     * Test if the functionality of checking if the email is empty works
     */
    @Test
    public void whenEmptyEmail_thenOneConstraintViolation() {
        // create a patient object
        Patient patient = new Patient();
        // set the email to be empty
        patient.setEmail(email);
        
        // validate the patient object
        Set<ConstraintViolation<Patient>> violations = validator.validate(patient);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    /*
     * Test if the functionality of checking if the password is empty works
     */
    @Test
    public void whenEmptyPassword_thenOneConstraintViolation() {
        // create a patient object
        Patient patient = new Patient();
        // set the password to be empty
        patient.setPassword(password);
        
        // validate the patient object
        Set<ConstraintViolation<Patient>> violations = validator.validate(patient);
        assertThat(violations.size()).isNotEqualTo(0);
    }

}
