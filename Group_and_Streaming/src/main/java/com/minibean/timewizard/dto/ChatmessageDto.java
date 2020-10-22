package com.minibean.timewizard.dto;


public class ChatmessageDto {
	private String chatRoomId;
	private String writer;
	private String message;
	private MessageType type;

	
	
	
	public ChatmessageDto() {
	
		
	}

	public enum MessageType {
	    ENTER,CHAT,LEAVE
	}
	
	public ChatmessageDto(String chatRoomId, String writer, String message, MessageType type) {
		this.chatRoomId = chatRoomId;
		this.writer = writer;
		this.message = message;
		this.type = type;
	}



	public String getChatRoomId() {
		return chatRoomId;
	}

	public void setChatRoomId(String chatRoomId) {
		this.chatRoomId = chatRoomId;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public MessageType getType() {
		return type;
	}

	public void setType(MessageType type) {
		this.type = type;
	}

}
