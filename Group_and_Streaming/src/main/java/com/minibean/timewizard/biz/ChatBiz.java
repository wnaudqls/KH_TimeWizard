package com.minibean.timewizard.biz;

import java.util.List;

import com.minibean.timewizard.dto.ChatDto;

public interface ChatBiz {
public void init();
	
	public List<ChatDto> selectList();
	
	public ChatDto selectOne(String user_id);
	
	public ChatDto Insert(String user_id);

}
