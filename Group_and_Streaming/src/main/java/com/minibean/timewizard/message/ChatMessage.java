package com.minibean.timewizard.message;


public class ChatMessage {
    private String roomid;
    private String writer;
    private String message;
    private MessageType type;
    

    
    
	public String getRoomid() {
		return roomid;
	}

	public void setRoomid(String roomid) {
		this.roomid = roomid;
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

	@Override
	public String toString() {
		return "ChatMessage [roomid=" + roomid + ", writer=" + writer + ", message=" + message + ", type=" + type + "]";
	}


	 
	
	
}
