package com.group8.neighborhood_doctors.chat;

import java.util.Set;
import javax.validation.ValidatorFactory;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.*;

/*
 * This class tests the Chat class
 */

public class ChatTests {
    // create a validator factory
    ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
    // create a validator
    Validator validator = factory.getValidator();

    private String time;
    private String message;
    private int userone;
    private int usertwo;

    @Test
    public void testTime() {
        Chat chat = new Chat();
        chat.setTime(time);
        Set<ConstraintViolation<Chat>> violations = validator.validate(chat);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    @Test
    public void testMessage() {
        Chat chat = new Chat();
        chat.setMessage(message);
        Set<ConstraintViolation<Chat>> violations = validator.validate(chat);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    @Test
    public void testUserone() {
        Chat chat = new Chat();
        chat.setUserone(userone);
        Set<ConstraintViolation<Chat>> violations = validator.validate(chat);
        assertThat(violations.size()).isNotEqualTo(0);
    }

    @Test
    public void testUsertwo() {
        Chat chat = new Chat();
        chat.setUsertwo(usertwo);
        Set<ConstraintViolation<Chat>> violations = validator.validate(chat);
        assertThat(violations.size()).isNotEqualTo(0);
    }
}
