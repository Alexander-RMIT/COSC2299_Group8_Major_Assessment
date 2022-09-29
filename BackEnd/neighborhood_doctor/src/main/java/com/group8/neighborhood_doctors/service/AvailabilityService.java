package com.group8.neighborhood_doctors.service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group8.neighborhood_doctors.availability.Availability;
import com.group8.neighborhood_doctors.repository.AvailabilityRepo;
import com.group8.neighborhood_doctors.repository.DoctorRepo;

@Service
public class AvailabilityService {
    @Autowired
    private AvailabilityRepo availabilityRepo;

    @Autowired
    private DoctorRepo doctorRepo;

    @Transactional
    public String createAvailability(Availability availability){
        try {
            // Check if the doctor exists in the database
            if (doctorRepo.existsById(availability.getDoctorId())) {
                // If date, timeStart, timeEnd, doctorId and patientId are not unique, then the availability already exists
                if (!(availabilityRepo.existsByDate(availability.getDate()) && availabilityRepo.existsByStart(availability.getStart()) && 
                        availabilityRepo.existsByEnd(availability.getEnd()) && availabilityRepo.existsByDoctorId(availability.getDoctorId()))) {
                    availability.setId(null == availabilityRepo.findMaxId()? 1 : availabilityRepo.findMaxId() + 1);
                    availabilityRepo.save(availability);
                    return "[SUCCESS] New availability record created successfully.";
                } else {
                    return "[FAILED] Reason: Availability already exists in the database.";
                }
            } else {
                return "[FAILED] Reason: Doctor does not exist in the database.";
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
                return "[SUCCESS] Availability record updated.";
            } catch (Exception e) {
                throw e;
            }
        } else {
            return "[FAILED] Reason: Availability does not exists in the database.";
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
                return "[SUCCESS] Availability record deleted successfully.";
            } catch (Exception e) {
                throw e;
            }

        } else {
            return "[FAILED] Reason: Availability does not exist";
        }
    }

}