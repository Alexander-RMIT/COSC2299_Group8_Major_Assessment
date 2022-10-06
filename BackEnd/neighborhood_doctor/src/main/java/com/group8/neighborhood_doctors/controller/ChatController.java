package com.group8.neighborhood_doctors.controller;

import com.group8.neighborhood_doctors.chat.Chat;

import com.group8.neighborhood_doctors.service.ChatService;

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

    @Autowired
    private ChatService chatService;

    /*
     * [POST] Create Chat
     */
    @RequestMapping(value = "chat/createChat", method = RequestMethod.POST)
    public String createChat(@RequestBody Chat chat){
        return chatService.createChat(chat);
    }

    /*
     * [GET] Read Chats
     */
    @RequestMapping(value = "chat/readChats", method = RequestMethod.GET)
    public List<Chat> readChats(){
        return chatService.readChats();
    }

    /*
     * [DELETE] Delete Chat
     * Only id is needed to delete a chat
     */
    @RequestMapping(value = "chat/deleteChat", method = RequestMethod.DELETE)
    public String deleteChat(@RequestBody Chat chat){
        return chatService.deleteChat(chat);
    }
}
