package com.minibean.timewizard.model.dto;




import org.springframework.web.socket.handler.TextWebSocketHandler;

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
