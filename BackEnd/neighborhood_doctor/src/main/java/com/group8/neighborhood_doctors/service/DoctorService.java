package com.group8.neighborhood_doctors.service;

import com.group8.neighborhood_doctors.entity.Doctor;
import com.group8.neighborhood_doctors.repository.DoctorRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class DoctorService {
    @Autowired
    private DoctorRepo doctorRepo;

    @Transactional
    public String createDoctor(Doctor doctor) {
        try {
            if (!(doctorRepo.existsByUsername(doctor.getFirst_name()) && doctorRepo.existsByUsername(doctor.getLast_name()))) {
                doctor.setId(null == doctorRepo.findMaxId()? 0 : doctorRepo.findMaxId() + 1);
                doctorRepo.save(doctor);
                return "Doctor record created successfully.";
            } else {
                return "Doctor already exists in the database.";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public List<Doctor> readAdmins() {
        return doctorRepo.findAll();
    }

    @Transactional
    public String updateAdmin(Doctor doctor) {
        if (doctorRepo.existsById(doctor.getId())) {
            try {
                Optional<Doctor> doctors = doctorRepo.findById(doctor.getId());
                doctors.stream().forEach(s -> {
                    Doctor adminToBeUpdate = doctorRepo.findById(s.getId()).get();
                    adminToBeUpdate.setFirst_name(doctor.getFirst_name());
                    adminToBeUpdate.setLast_name(doctor.getLast_name());
                    adminToBeUpdate.setEmail(doctor.getEmail());
                    adminToBeUpdate.setPassword(doctor.getPassword());
                    doctorRepo.save(adminToBeUpdate);
                });
                return "Doctor record updated.";
            } catch (Exception e) {
                throw e;
            }
        } else {
            return "Doctor does not exists in the database.";
        }
    }


}
