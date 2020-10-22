package com.minibean.timewizard.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.dao.ChatDao;
import com.minibean.timewizard.dto.ChatDto;

@Service // Biz
public class ChatBizImpl implements ChatBiz{

	@Autowired
	ChatDao dao;

	@Override
	public void init() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ChatDto> selectList() {
		// TODO Auto-generated method stub
		return dao.selectList();
	}

	@Override
	public ChatDto selectOne(String user_id) {
		// TODO Auto-generated method stub
		return dao.selectOne(user_id);
	}

	@Override
	public ChatDto Insert(String user_id) {
		// TODO Auto-generated method stub
		return dao.Insert(user_id);
	}

}
