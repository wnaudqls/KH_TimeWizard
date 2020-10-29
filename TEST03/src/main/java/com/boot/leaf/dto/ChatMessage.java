package com.boot.leaf.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString 
public class ChatMessage {
    private String chatRoomId;
    private String writer;
    private String message;
    private MessageType type;
    
	/*
	 * public String getChatRoomId() { return chatRoomId; } public void
	 * setChatRoomId(String chatRoomId) { this.chatRoomId = chatRoomId; } public
	 * String getWriter() { return writer; } public void setWriter(String writer) {
	 * this.writer = writer; } public String getMessage() { return message; } public
	 * void setMessage(String message) { this.message = message; } public
	 * MessageType getType() { return type; } public void setType(MessageType type)
	 * { this.type = type; }
	 * 
	 * @Override public String toString() { return "ChatMessage [chatRoomId=" +
	 * chatRoomId + ", writer=" + writer + ", message=" + message + ", type=" + type
	 * + "]"; }
	 */
	
	
}
