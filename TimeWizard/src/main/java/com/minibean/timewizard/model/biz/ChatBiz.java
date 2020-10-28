package com.minibean.timewizard.model.biz;

import java.util.List;

import com.minibean.timewizard.model.dto.ChatDto;

public interface ChatBiz {

	int insert(ChatDto chat);

	List<ChatDto> selectList();

	ChatDto selectOne(String name);
}
