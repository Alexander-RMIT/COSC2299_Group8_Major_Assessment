package com.group8.neighborhood_doctors;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class NeighborhoodDoctorsApplication {

	public static void main(String[] args) {
		SpringApplication.run(NeighborhoodDoctorsApplication.class, args);
	}

	@GetMapping("/")
	public String index() {
		return "Welcome! This is a Spring Boot application for Neighborhood Doctors!";
	}
}
