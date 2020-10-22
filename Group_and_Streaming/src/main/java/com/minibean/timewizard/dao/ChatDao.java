package com.minibean.timewizard.dao;

import java.util.List;

import com.minibean.timewizard.dto.ChatDto;

public interface ChatDao {
	String namespace = "chat-mapper.";
	public void init();
	
	public List<ChatDto> selectList();
	
	public ChatDto selectOne(String user_id);
	
	public ChatDto Insert(String user_id);

}
