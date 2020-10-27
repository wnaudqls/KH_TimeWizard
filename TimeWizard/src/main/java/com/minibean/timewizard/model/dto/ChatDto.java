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
		//무작위  고유식별자를 String으로 리턴한 값을 roomid에 대입
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
	
	
	

	public void handleMessage(WebSocketSession session, ChatMessage chatMessage, ObjectMapper objectMapper)
			throws Exception {
			//chatMessage의 Type이 ENTER일 경우 
		if (chatMessage.getType() == MessageType.ENTER) {
			System.out.println("type: " + chatMessage.getType());
			//sessionList에 저장
			sessionList.add(session);
			//보낼 메세지 설정
			chatMessage.setMessage(chatMessage.getWriter() + "님이 입장하셨습니다.");
			//메세지 전송
			send(chatMessage, objectMapper);
			System.out.println("asdf: " +sessionList);
			
			//chatMessage의 Type이 LEAVE일 경우
		} else if (chatMessage.getType() == MessageType.LEAVE) {
			//해당 세션을 sessionList에서 삭제함
			sessionList.remove(session);
			chatMessage.setMessage(chatMessage.getWriter() + "님이 퇴장하셨습니다.");
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
	
		//세션리스트에 저장된 세션을 담아옴
		for (WebSocketSession sess : sessionList) {
			//세션들에게 메세지를 보냄
			sess.sendMessage(textMessage);
		}
	}
	
	@Override
	public String toString() {
		return "방 번호: " + roomid + "\n 이름: " + name + "\n 세션목록: " + sessionList;
	}


}
