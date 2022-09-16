package com.group8.neighborhood_doctors.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.group8.neighborhood_doctors.appointment.Appointment;

@Repository
public interface AppointmentRepo extends JpaRepository<Appointment, Integer> {
    public boolean existsById(int id);

    public boolean existsByDate(String date);

    public boolean existsByTimeStart(String timeStart);

    public boolean existsByTimeEnd(String timeEnd);

    public boolean existsByDoctorId(int doctorId);

    public boolean existsByPatientId(int patientId);

    @Query("select max(s.id) from Appointment s")
    public Integer findMaxId();
}
