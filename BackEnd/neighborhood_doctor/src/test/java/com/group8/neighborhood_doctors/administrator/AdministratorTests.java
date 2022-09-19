package com.group8.neighborhood_doctors.administrator;

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
 * This class tests the Administrator class
 */

public class AdministratorTests {
    // create a validator factory
    ValidatorFactory factory;
    // create a validator
    Validator validator;

    private String username;
    private String password;
    private String email;

    @BeforeEach
    @DisplayName("Create a validator factory and a validator")
    void setup() {
        factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    /*
     * Test if the functionality of checking if the username is empty works
     */
    @Test
    void whenEmptyUsername_thenOneConstraintViolation() {
        // create a administrator object
        Administrator administrator = new Administrator();
        // set the username to be empty
        administrator.setUsername(username);

        // validate the administrator object
        Set<ConstraintViolation<Administrator>> violations = validator.validate(administrator);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    /*
     * Test if the functionality of checking if the password is empty works
     */
    @Test
    void whenEmptyPassword_thenOneConstraintViolation() {
        // create a administrator object
        Administrator administrator = new Administrator();
        // set the password to be empty
        administrator.setPassword(password);

        // validate the administrator object
        Set<ConstraintViolation<Administrator>> violations = validator.validate(administrator);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    /*
     * Test if the functionality of checking if the email is empty works
     */
    @Test
    void whenEmptyEmail_thenOneConstraintViolation() {
        // create a administrator object
        Administrator administrator = new Administrator();
        // set the email to be empty
        administrator.setEmail(email);

        // validate the administrator object
        Set<ConstraintViolation<Administrator>> violations = validator.validate(administrator);
        assertThat(violations.size()).isNotEqualTo(0);
    }
}
