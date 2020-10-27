package com.minibean.timewizard.model.dao;

import java.util.List;

import com.minibean.timewizard.model.dto.ChatDto;

public interface ChatDao {

	String namespace = "chat-mapper.";
	List<ChatDto> findAllRoom();

	ChatDto findRoomById(String id);

	ChatDto createChatRoom(String name);
	
	int insert(ChatDto chat);
	
	List<ChatDto> selectList();
	
	ChatDto selectOne(String name);

	

}
