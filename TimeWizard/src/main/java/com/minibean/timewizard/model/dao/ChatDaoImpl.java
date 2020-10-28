package com.minibean.timewizard.model.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.ChatDto;


@Repository
public class ChatDaoImpl implements ChatDao{
    private Map<String, ChatDto> chatRoomMap = new HashMap<String, ChatDto>();

    @Autowired
	private SqlSessionTemplate sqlSession;
    
    @PostConstruct
    private void init(){
        chatRoomMap = new LinkedHashMap<>();
    }
    

	@Override
	public List<ChatDto> selectList() {
		// TODO Auto-generated method stub
		List<ChatDto> list = new ArrayList<ChatDto>();
		try {
			list = sqlSession.selectList(namespace+"selectList");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int insert(ChatDto chat) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.insert(namespace+"insert",chat);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}



	@Override
	public ChatDto selectOne(String name) {
		// TODO Auto-generated method stub
		ChatDto room = new ChatDto();
		try {
			room = sqlSession.selectOne(namespace+"selectOne",name);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return room;
	}

}
