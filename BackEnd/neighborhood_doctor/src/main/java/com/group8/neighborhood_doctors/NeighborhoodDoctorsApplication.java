package com.group8.neighborhood_doctors;

// import ch.qos.logback.core.net.SyslogOutputStream;
// import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
// import org.springframework.jdbc.core.JdbcTemplate;

// Added to deal with CORS error on desktop
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;


// implements CommandLineRunner
@SpringBootApplication
public class NeighborhoodDoctorsApplication {

	public static void main(String[] args) {
		SpringApplication.run(NeighborhoodDoctorsApplication.class, args);
	}


	@Bean
	public WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurerAdapter() {
		    @Override
		    public void addCorsMappings(CorsRegistry registry) {
			registry.addMapping("/**").allowedOrigins("*");
		    }
		};
	}
}
