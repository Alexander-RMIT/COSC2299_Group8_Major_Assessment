package com.group8.neighborhood_doctors.service;

import com.group8.neighborhood_doctors.availability.Availability;
import com.group8.neighborhood_doctors.repository.AvailabilityRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class AvailabilityService {
    @Autowired
    private AvailabilityRepo availabilityRepo;

    @Transactional
    public String createAvailability(Availability availability){
        try {
            // If date, timeStart, timeEnd, doctorId and patientId are not unique, then the availability already exists
            if (!(availabilityRepo.existsByDate(availability.getDate()) && availabilityRepo.existsByStart(availability.getStart()) && 
                    availabilityRepo.existsByEnd(availability.getEnd()) && availabilityRepo.existsByDoctorId(availability.getDoctorId()))) {
                availability.setId(null == availabilityRepo.findMaxId()? 1 : availabilityRepo.findMaxId() + 1);
                availabilityRepo.save(availability);
                return "New availability record created successfully.";
            } else {
                return "Availability already exists in the database.";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public List<Availability> readAvailabilities() {
        return availabilityRepo.findAll();
    }

    @Transactional
    public String updateAvailability(Availability availability) {
        if (availabilityRepo.existsById(availability.getId())) {
            try {
                Optional<Availability> avalabilities = availabilityRepo.findById(availability.getId());
                avalabilities.stream().forEach(s -> {
                    Availability availabilityToBeUpdate = availabilityRepo.findById(s.getId()).get();
                    availabilityToBeUpdate.setDoctorId(availability.getDoctorId());
                    availabilityToBeUpdate.setDate(availability.getDate());
                    availabilityToBeUpdate.setStart(availability.getStart());
                    availabilityToBeUpdate.setEnd(availability.getEnd());
                    availabilityToBeUpdate.setStatus(availability.getStatus());
                    availabilityRepo.save(availabilityToBeUpdate);
                });
                return "Availability record updated.";
            } catch (Exception e) {
                throw e;
            }
        } else {
            return "Availability does not exists in the database.";
        }
    }

    @Transactional
    public String deleteAvailability(Availability availability) {
        if (availabilityRepo.existsById(availability.getId())) {
            try {
                Optional<Availability> availabilitys = availabilityRepo.findById(availability.getId());
                availabilitys.stream().forEach(s -> {
                    availabilityRepo.delete(s);
                });
                return "Availability record deleted successfully.";
            } catch (Exception e) {
                throw e;
            }

        } else {
            return "Availability does not exist";
        }
    }

}