package com.minibean.timewizard.message;


public class ChatMessage {
    private String chat_title;
    private String writer;
    private String message;
    private MessageType type;
    

    
    
	public String getChat_title() {
		return chat_title;
	}

	public void setChat_title(String chat_title) {
		this.chat_title = chat_title;
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
		return "ChatMessage [chat_title=" + chat_title + ", writer=" + writer + ", message=" + message + ", type=" + type + "]";
	}


	 
	
	
}
