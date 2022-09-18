package com.group8.neighborhood_doctors.service;

import com.group8.neighborhood_doctors.appointment.Appointment;
import com.group8.neighborhood_doctors.repository.AppointmentRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class AppointmentService {
    @Autowired
    private AppointmentRepo appointmentRepo;

    @Transactional
    public String createAppointment(Appointment appointment){
        try {
            // If date, timeStart, timeEnd, doctorId and patientId are not unique, then the appointment already exists
            if (!(appointmentRepo.existsByDate(appointment.getDate()) && appointmentRepo.existsByTimeStart(appointment.getTimeStart()) && 
                    appointmentRepo.existsByTimeEnd(appointment.getTimeEnd()) && appointmentRepo.existsByDoctorId(appointment.getDoctorId()) && 
                    appointmentRepo.existsByPatientId(appointment.getPatientId()))) {
                appointment.setId(null == appointmentRepo.findMaxId()? 1 : appointmentRepo.findMaxId() + 1);
                appointmentRepo.save(appointment);
                return "New appointment record created successfully.";
            } else {
                return "Appointment already exists in the database.";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public List<Appointment> readAppointments() {
        return appointmentRepo.findAll();
    }

    @Transactional
    public String updateAppointment(Appointment appointment) {
        if (appointmentRepo.existsById(appointment.getId())) {
            try {
                Optional<Appointment> appointments = appointmentRepo.findById(appointment.getId());
                appointments.stream().forEach(s -> {
                    Appointment appointmentToBeUpdate = appointmentRepo.findById(s.getId()).get();
                    appointmentToBeUpdate.setDate(appointment.getDate());
                    appointmentToBeUpdate.setTimeStart(appointment.getTimeStart());
                    appointmentToBeUpdate.setTimeEnd(appointment.getTimeEnd());
                    appointmentToBeUpdate.setDoctorId(appointment.getDoctorId());
                    appointmentToBeUpdate.setPatientId(appointment.getPatientId());
                    appointmentToBeUpdate.setDescription(appointment.getDescription());
                    appointmentRepo.save(appointmentToBeUpdate);
                });
                return "Appointment record updated.";
            } catch (Exception e) {
                throw e;
            }
        } else {
            return "Appointment does not exists in the database.";
        }
    }

    @Transactional
    public String deleteAppointment(Appointment appointment) {
        if (appointmentRepo.existsById(appointment.getId())) {
            try {
                Optional<Appointment> appointments = appointmentRepo.findById(appointment.getId());
                appointments.stream().forEach(s -> {
                    appointmentRepo.delete(s);
                });
                return "Appointment record deleted successfully.";
            } catch (Exception e) {
                throw e;
            }

        } else {
            return "Appointment does not exist";
        }
    }

}
