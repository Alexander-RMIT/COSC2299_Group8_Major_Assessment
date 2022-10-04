package com.group8.neighborhood_doctors;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootApplication
public class NeighborhoodDoctorsApplication {

	public static void main(String[] args) {
		SpringApplication.run(NeighborhoodDoctorsApplication.class, args);
	}

	/*
	 * This bean is used to encode the password.
	 */
	@Bean
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}

}
