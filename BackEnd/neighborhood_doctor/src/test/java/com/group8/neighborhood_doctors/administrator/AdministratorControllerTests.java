package com.group8.neighborhood_doctors.administrator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.group8.neighborhood_doctors.repository.AdministratorRepo;

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
public class AdministratorControllerTests {
    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private AdministratorRepo administratorRepo;

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
     * [POST] Test whether the controller can create a new admin properly
     */
    @Test
    void testCreateAdmin() throws Exception {
        Administrator administrator = new Administrator();
        administrator.setEmail("group8Test@gmail.com");
        administrator.setUsername("group8Test");
        administrator.setPassword("IAmTest");
        
        doReturn(administrator).when(administratorRepo).save(any());

        mockMvc.perform(post("/admin/createAdmin")
                .contentType(MediaType.APPLICATION_JSON)
                .content(asJsonString(administrator)))
                .andExpect(status().isOk());
    }

    /* 
     * [GET] Test whether the controller can return a list of all admins properly
     */
    @Test
    void testReadAdmins() throws Exception {
        mockMvc.perform(get("/admin/readAdmins"))
                .andExpect(status().isOk());
    }
    
    /*
     * [PUT] Test whether the updateAdmin method works properly
     */
    @Test
    void testUpdateAdmin() throws Exception {
        Administrator administrator = new Administrator();
        administrator.setEmail("group8Test@gmail.com");
        administrator.setUsername("group8Test");
        administrator.setPassword("IAmTest");

        doReturn(Optional.of(administrator)).when(administratorRepo).findById(any());
        doReturn(administrator).when(administratorRepo).save(any());

        mockMvc.perform(put("/admin/updateAdmin").contentType(MediaType.APPLICATION_JSON).content(asJsonString(administrator)))
                .andExpect(status().isOk());
    }

    /*
     * [DELETE] Test whether the deleteAdmin method works properly
     */
    @Test
    void testDeleteAccount() throws Exception {
        Administrator administrator = new Administrator();
        administrator.setEmail("group8Test@gmail.com");
        administrator.setUsername("group8Test");
        administrator.setPassword("IAmTest");

        doReturn(Optional.of(administrator)).when(administratorRepo).findById(any());

        mockMvc.perform(delete("/admin/deleteAdmin").contentType(MediaType.APPLICATION_JSON).content(asJsonString(administrator)))
                .andExpect(status().isOk());
    }
}
