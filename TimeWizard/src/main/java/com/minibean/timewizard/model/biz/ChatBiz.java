package com.minibean.timewizard.model.biz;

import java.util.List;

import com.minibean.timewizard.model.dto.ChatDto;

public interface ChatBiz {

	List<ChatDto> findAllRoom();

	ChatDto findRoomById(String id);

	ChatDto createChatRoom(String name);

	int insert(ChatDto chat);

	List<ChatDto> selectList();

	ChatDto selectOne(String name);
}
