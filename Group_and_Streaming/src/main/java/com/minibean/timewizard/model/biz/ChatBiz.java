package com.minibean.timewizard.model.biz;

import java.util.List;

import com.minibean.timewizard.model.dto.ChatDto;

public interface ChatBiz {

	public int insert(ChatDto chat);

	public List<ChatDto> selectList();

	public ChatDto selectOne(String name);

	public int clientplus(String name);
	
	public int kaboom(String name);

	public int clientminus(String name);
	
	public ChatDto clientnum(String name);
}
