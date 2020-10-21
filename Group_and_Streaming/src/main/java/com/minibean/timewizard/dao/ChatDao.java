package com.minibean.timewizard.dao;

import java.util.List;

import com.minibean.timewizard.dto.ChatDto;

public interface ChatDao {
	public void init();
	
	public List<ChatDto> findAllRoom();
	
	public ChatDto findRoomById(String user_id);
	
	public ChatDto createChatRoom(String user_id);

}
