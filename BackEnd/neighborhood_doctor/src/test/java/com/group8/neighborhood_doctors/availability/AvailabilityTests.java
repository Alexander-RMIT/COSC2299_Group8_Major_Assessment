package com.group8.neighborhood_doctors.availability;

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
 * This class tests the Availability class
 */

public class AvailabilityTests {
    // create a validator factory
    ValidatorFactory factory;
    // create a validator
    Validator validator;

    private int doctorId;
    private String date;
    private String status;
    private String start;
    private String end;

    @BeforeEach
    @DisplayName("Create a validator factory and a validator")
    void setup() {
        factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    /*
     * Test if the functionality of checking if the doctorId is null works
     */
    @Test
    void whenNullDoctorId_thenOneConstraintViolation() {
        // create a availability object
        Availability availability = new Availability();
        // set the doctorId to be null
        availability.setDoctorId(doctorId);

        // validate the availability object
        Set<ConstraintViolation<Availability>> violations = validator.validate(availability);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    /*
     * Test if the functionality of checking if the date is empty works
     */
    @Test
    void whenEmptyDate_thenOneConstraintViolation() {
        // create a availability object
        Availability availability = new Availability();
        // set the date to be empty
        availability.setDate(date);

        // validate the availability object
        Set<ConstraintViolation<Availability>> violations = validator.validate(availability);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    /*
     * Test if the functionality of checking if the status is empty works
     */
    @Test
    void whenEmptyStatus_thenOneConstraintViolation() {
        // create a availability object
        Availability availability = new Availability();
        // set the status to be empty
        availability.setStatus(status);

        // validate the availability object
        Set<ConstraintViolation<Availability>> violations = validator.validate(availability);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    /*
     * Test if the functionality of checking if the start is empty works
     */
    @Test
    void whenEmptyStart_thenOneConstraintViolation() {
        // create a availability object
        Availability availability = new Availability();
        // set the start to be empty
        availability.setStart(start);

        // validate the availability object
        Set<ConstraintViolation<Availability>> violations = validator.validate(availability);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    /*
     * Test if the functionality of checking if the end is empty works
     */
    @Test
    void whenEmptyEnd_thenOneConstraintViolation() {
        // create a availability object
        Availability availability = new Availability();
        // set the end to be empty
        availability.setEnd(end);

        // validate the availability object
        Set<ConstraintViolation<Availability>> violations = validator.validate(availability);
        assertThat(violations.size()).isNotEqualTo(0);
    }

}
