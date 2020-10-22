package com.minibean.timewizard.dto;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.minibean.timewizard.dto.ChatmessageDto.MessageType;

public class ChatDto {

	int chat_no;
	int group_no;
	String user_id;
	String chat_content;
	private static Set<WebSocketSession> sessions = new HashSet<>();

	public static ChatDto create(// int chat_no,
			String user_id) {
		ChatDto Chatroom = new ChatDto();
		// Chatroom.chat_no = chat_no;
		Chatroom.user_id = user_id;
		return Chatroom;
	}

	public ChatDto() {

	}

	public ChatDto(int chat_no, int group_no, String user_id, String chat_content) {
		this.chat_no = chat_no;
		this.group_no = group_no;
		this.user_id = user_id;
		this.chat_content = chat_content;
	}

	public int getChat_no() {
		return chat_no;
	}

	public void setChat_no(int chat_no) {
		this.chat_no = chat_no;
	}

	public int getGroup_no() {
		return group_no;
	}

	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getChat_content() {
		return chat_content;
	}

	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}

	public static void handleMessage(WebSocketSession session, ChatmessageDto chatMessage, ObjectMapper objectMapper)
			throws IOException {
		if (chatMessage.getType() == MessageType.ENTER) {
			sessions.add(session);
			chatMessage.setMessage(chatMessage.getWriter() + "님이 입장하셨습니다.");
		} else if (chatMessage.getType() == MessageType.LEAVE) {
			sessions.remove(session);
			chatMessage.setMessage(chatMessage.getWriter() + "님임 퇴장하셨습니다.");
		} else {
			chatMessage.setMessage(chatMessage.getWriter() + " : " + chatMessage.getMessage());
		}
		send(chatMessage, objectMapper);
	}

	private static void send(ChatmessageDto chatMessage, ObjectMapper objectMapper) throws IOException {
		TextMessage textMessage = new TextMessage(objectMapper.writeValueAsString(chatMessage.getMessage()));
		for (WebSocketSession sess : sessions) {
			sess.sendMessage(textMessage);
		}
	}

}
