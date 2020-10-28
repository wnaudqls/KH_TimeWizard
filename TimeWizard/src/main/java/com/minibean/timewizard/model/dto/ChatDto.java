package com.minibean.timewizard.model.dto;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.minibean.timewizard.message.ChatMessage;
import com.minibean.timewizard.message.MessageType;

public class ChatDto extends TextWebSocketHandler{
	
	String roomid;
	String name;
 
	public String getRoomid() {
		return roomid;
	}

	public void setRoomid(String roomid) {
		this.roomid = roomid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	

}
