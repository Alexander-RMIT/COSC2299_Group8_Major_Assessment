package com.group8.neighborhood_doctors.doctor;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.group8.neighborhood_doctors.repository.DoctorRepo;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Optional;

import static org.mockito.Mockito.doReturn;
import static org.mockito.ArgumentMatchers.any;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
public class DocterControllerTests {
    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private DoctorRepo doctorRepo;

    String asJsonString(final Object obj) {
        try {
            final ObjectMapper mapper = new ObjectMapper();
            final String jsonContent = mapper.writeValueAsString(obj);
            return jsonContent;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /*
     * [POST] Test whether the controller can create a new doctor properly
     */
    @Test
    void testCreateDoctor() throws Exception {
        Doctor doctor = new Doctor();
        doctor.setFirstname("Group8");
        doctor.setLastname("Test");
        doctor.setEmail("group8Test@gmail.com");
        doctor.setPassword("IAmTest");

        doReturn(doctor).when(doctorRepo).save(any());

        mockMvc.perform(post("/doctor/createDoctor")
                .contentType(MediaType.APPLICATION_JSON)
                .content(asJsonString(doctor)))
                .andExpect(status().isOk());
    }

    /*
     * [GET] Test whether the controller can return a list of all doctors properly
     */
    @Test
    void testGetAllDoctors() throws Exception {
        mockMvc.perform(get("/doctor/readDoctors"))
                .andExpect(status().isOk());
    }
    
    /*
     * [PUT] Test whether the updateDoctor method works properly
     */
    @Test
    void testUpdateDoctor() throws Exception {
        Doctor doctor = new Doctor();
        doctor.setFirstname("Group8");
        doctor.setLastname("Test");
        doctor.setEmail("group8Test@gmail.com");
        doctor.setPassword("IAmTest");

        doReturn(Optional.of(doctor)).when(doctorRepo).findById(any());
        doReturn(doctor).when(doctorRepo).save(any());

        mockMvc.perform(put("/doctor/updateDoctor").contentType(MediaType.APPLICATION_JSON).content(asJsonString(doctor)))
                .andExpect(status().isOk());
    }

    /*
     * [DELETE] Test whether the deleteDoctor method works properly
     */
    @Test
    void testDeleteDoctor() throws Exception {
        Doctor doctor = new Doctor();
        doctor.setFirstname("Group8");
        doctor.setLastname("Test");
        doctor.setEmail("group8Test@gmail.com");
        doctor.setPassword("IAmTest");

        doReturn(Optional.of(doctor)).when(doctorRepo).findById(any());

        mockMvc.perform(delete("/doctor/deleteDoctor").contentType(MediaType.APPLICATION_JSON).content(asJsonString(doctor)))
                .andExpect(status().isOk());

    }

}
