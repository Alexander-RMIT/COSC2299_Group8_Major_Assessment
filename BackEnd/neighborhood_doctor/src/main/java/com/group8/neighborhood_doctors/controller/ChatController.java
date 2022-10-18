package com.group8.neighborhood_doctors.controller;

import com.group8.neighborhood_doctors.chat.Chat;
import com.group8.neighborhood_doctors.jwt.JwtUtility;

import com.group8.neighborhood_doctors.service.ChatService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


import java.util.List;

/*
    =======================
        Chat Controller
    =======================
*/

@RestController
public class ChatController {

    private static final Logger logger = LogManager.getLogger(ChatController.class);

    @Autowired
    private ChatService chatService;

    /*
     * [POST] Create Chat
     */
    @RequestMapping(value = "chat/createChat", method = RequestMethod.POST)
    public String createChat(@RequestBody Chat chat){
        logger.info("Creating a new chat");
        return chatService.createChat(chat);
    }

    /*
     * [GET] Read Chats
     */
    @RequestMapping(value = "chat/readChats", method = RequestMethod.GET)
    public List<Chat> readChats(){
        logger.info("Reading all chats");
        return chatService.readChats();
    }

    /*
     * [DELETE] Delete Chat
     * Only id is needed to delete a chat
     */
    @RequestMapping(value = "chat/deleteChat", method = RequestMethod.DELETE)
    public String deleteChat(@RequestBody Chat chat){
        logger.info("Deleting a chat");
        return chatService.deleteChat(chat);
    }


    @RequestMapping(value="chat/retrieveAllChats", method=RequestMethod.POST)
    public String retrieveAllChats(@RequestBody String token) {
        logger.info("Retrieving all chats using JWT Token");
        JwtUtility util = new JwtUtility();

        if (util.verifyToken(token)) {
            String chats = chatService.readChatsString();
            logger.info("Valid Token");
            return chats;
        } else {
            logger.error("Invalid token");
            return "";
        }
    }
}