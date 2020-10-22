package com.minibean.timewizard.dto;

public class ChatDto {
	
	int chat_no;
	int group_no;
	String user_id;
	String chat_content;
	
	public static ChatDto create(//int chat_no,
			String user_id) {
		ChatDto Chatroom = new ChatDto();
		//Chatroom.chat_no = chat_no;
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
	
}
