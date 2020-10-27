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
    Set<WebSocketSession> sessionList = new HashSet<WebSocketSession>();

	public static ChatDto create(String name) {
		ChatDto chatRoom = new ChatDto();
		chatRoom.roomid = UUID.randomUUID().toString();
		chatRoom.name = name;
		return chatRoom;
	}

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


	public Set<WebSocketSession> getSessionList() {
		return sessionList;
	}

	public void setSessionList(Set<WebSocketSession> sessionList) {
		this.sessionList = sessionList;
	}
	
	
	
	@Override
	public String toString() {
		return "ChatDto [roomid=" + roomid + ", name=" + name + ", sessionList=" + sessionList + "]";
	}

	public void handleMessage(WebSocketSession session, ChatMessage chatMessage, ObjectMapper objectMapper)
			throws Exception {
			
		if (chatMessage.getType() == MessageType.ENTER) {
			System.out.println("type: " + chatMessage.getType());
			sessionList.add(session);
			chatMessage.setMessage(chatMessage.getWriter() + "님이 입장하셨습니다.");
			send(chatMessage, objectMapper);
			System.out.println("asdf: " +sessionList);
		} else if (chatMessage.getType() == MessageType.LEAVE) {
			chatMessage.setMessage(chatMessage.getWriter() + "님이 퇴장하셨습니다.");
			sessionList.remove(session);
			send(chatMessage, objectMapper);
		} else {
			System.out.println("type: " + chatMessage.getType());
			System.out.println("[dto]세션: " + sessionList);
			chatMessage.setMessage(chatMessage.getWriter() + " : " + chatMessage.getMessage());
			send(chatMessage, objectMapper);
		}

	}

	private void send(ChatMessage chatMessage, ObjectMapper objectMapper) throws IOException {
		TextMessage textMessage = new TextMessage(objectMapper.writeValueAsString(chatMessage.getMessage()));

		for (WebSocketSession sess : sessionList) {
			sess.sendMessage(textMessage);
		}
	}

}
