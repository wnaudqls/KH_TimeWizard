package com.minibean.timewizard.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.dto.ChatDto;

@Repository //Dao
public class ChatDaoImpl implements ChatDao{
	
	
	ChatDto dto;
	
	
	private Map<String, ChatDto> chatmap;
	
	@PostConstruct
	public void init() {
		chatmap = new LinkedHashMap<String, ChatDto>();
	}
	
	public List<ChatDto> findAllRoom(){
		//채팅방 생성순서 최근 순으로 반환
		List <ChatDto> chatrooms = new ArrayList<ChatDto>(chatmap.values());
		Collections.reverse(chatrooms);
		return chatrooms;
	}
	
	public ChatDto findRoomById(String user_id) {
		return chatmap.get(user_id);
	}
	
	public ChatDto createChatRoom(String user_id) {
		ChatDto chatroom = ChatDto.create(user_id);
		chatmap.put(chatroom.getUser_id(),chatroom);
		return chatroom;
		
	}

}
