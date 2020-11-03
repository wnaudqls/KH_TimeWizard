package com.minibean.timewizard.model.dto;

public class ChatDto {

	int chat_no;
	String user_id;
	String chat_title;
	int chat_client;
	String chat_public;
	String chat_password;

	
	
	public ChatDto() {
		// TODO Auto-generated constructor stub
	}



	public ChatDto(int chat_no, String user_id, String chat_title, int chat_client, String chat_public,
			String chat_password) {
		this.chat_no = chat_no;
		this.user_id = user_id;
		this.chat_title = chat_title;
		this.chat_client = chat_client;
		this.chat_public = chat_public;
		this.chat_password = chat_password;
	}



	public int getChat_no() {
		return chat_no;
	}



	public void setChat_no(int chat_no) {
		this.chat_no = chat_no;
	}



	public String getUser_id() {
		return user_id;
	}



	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}



	public String getChat_title() {
		return chat_title;
	}



	public void setChat_title(String chat_title) {
		this.chat_title = chat_title;
	}



	public int getChat_client() {
		return chat_client;
	}



	public void setChat_client(int chat_client) {
		this.chat_client = chat_client;
	}



	public String getChat_public() {
		return chat_public;
	}



	public void setChat_public(String chat_public) {
		this.chat_public = chat_public;
	}



	public String getChat_password() {
		return chat_password;
	}



	public void setChat_password(String chat_password) {
		this.chat_password = chat_password;
	}



}
