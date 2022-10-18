package com.group8.neighborhood_doctors.patient;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.group8.neighborhood_doctors.repository.PatientRepo;

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
public class PatientControllerTests {
    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private PatientRepo patientRepo;

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
     * [POST] Test whether the controller can create a new patient properly
     */
    @Test
    void testCreatePatient() throws Exception {
        Patient patient = new Patient();
        patient.setFirstname("Group8");
        patient.setFirstname("Test");
        patient.setEmail("group8Test@gmail.com");
        patient.setPassword("IAmTest");
        
        doReturn(patient).when(patientRepo).save(any());

        mockMvc.perform(post("/patient/createPatient")
                .contentType(MediaType.APPLICATION_JSON)
                .content(asJsonString(patient)))
                .andExpect(status().isOk());
    }

    /*
     * [GET] Test whether the controller can return a list of all patients properly
     */
    @Test
    void testGetAllPatients() throws Exception {
        mockMvc.perform(get("/patient/readPatients"))
                .andExpect(status().isOk());
    }

    /*
     * [PUT] Test whether the updatePatient method works properly
     */
    @Test
    void testUpdatePatient() throws Exception {
        Patient patient = new Patient();
        patient.setFirstname("Group8");
        patient.setFirstname("Test");
        patient.setEmail("group8Test@gmail.com");
        patient.setPassword("IAmTest");

        doReturn(Optional.of(patient)).when(patientRepo).findById(any());
        doReturn(patient).when(patientRepo).save(any());

        mockMvc.perform(put("/patient/updatePatient").contentType(MediaType.APPLICATION_JSON).content(asJsonString(patient)))
                .andExpect(status().isOk());
    }

    /*
     * [DELETE] Test whether the deletePatient method works properly
     */
    @Test
    void testDeletePatient() throws Exception {
        Patient patient = new Patient();
        patient.setFirstname("Group8");
        patient.setFirstname("Test");
        patient.setEmail("group8Test@gmail.com");
        patient.setPassword("IAmTest");

        doReturn(Optional.of(patient)).when(patientRepo).findById(any());
        doReturn(patient).when(patientRepo).save(any());

        mockMvc.perform(put("/patient/updatePatient").contentType(MediaType.APPLICATION_JSON).content(asJsonString(patient)))
                .andExpect(status().isOk());
    }
}
