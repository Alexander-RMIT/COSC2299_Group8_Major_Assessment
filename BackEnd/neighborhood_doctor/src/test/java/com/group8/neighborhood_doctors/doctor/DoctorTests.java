package com.group8.neighborhood_doctors.doctor;

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
 * This class tests the Doctor class
 */

public class DoctorTests {
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
        // create a doctor object
        Doctor doctor = new Doctor();
        // set the first name to be empty
        doctor.setFirstname(firstname);

        // validate the doctor object
        Set<ConstraintViolation<Doctor>> violations = validator.validate(doctor);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    /*
     * Test if the functionality of checking if the last name is empty works
     */
    @Test
    public void whenEmptyLastname_thenOneConstraintViolation() {
        // create a doctor object
        Doctor doctor = new Doctor();
        // set the last name to be empty
        doctor.setLastname(lastname);

        // validate the doctor object
        Set<ConstraintViolation<Doctor>> violations = validator.validate(doctor);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    /*
     * Test if the functionality of checking if the email is empty works
     */
    @Test
    public void whenEmptyEmail_thenOneConstraintViolation() {
        // create a doctor object
        Doctor doctor = new Doctor();
        // set the email to be empty
        doctor.setEmail(email);

        // validate the doctor object
        Set<ConstraintViolation<Doctor>> violations = validator.validate(doctor);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    /*
     * Test if the functionality of checking if the password is empty works
     */
    @Test
    public void whenEmptyPassword_thenOneConstraintViolation() {
        // create a doctor object
        Doctor doctor = new Doctor();
        // set the password to be empty
        doctor.setPassword(password);

        // validate the doctor object
        Set<ConstraintViolation<Doctor>> violations = validator.validate(doctor);
        assertThat(violations.size()).isNotEqualTo(0);
    }
}
