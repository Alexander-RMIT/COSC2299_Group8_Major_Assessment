package com.group8.neighborhood_doctors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class NeighborhoodDoctorsApplication {

	private static final Logger logger = LogManager.getLogger(NeighborhoodDoctorsApplication.class);

	public static void main(String[] args) {
		SpringApplication.run(NeighborhoodDoctorsApplication.class, args);
	}

	@GetMapping("/")
	public String index() {
		logger.trace("A TRACE Message");
        logger.debug("A DEBUG Message");
        logger.info("An INFO Message");
        logger.warn("A WARN Message");
        logger.error("An ERROR Message");
		logger.fatal("A FATAL Message");
		return "Welcome! This is a Spring Boot application for Neighborhood Doctors!";
	}
}
