package com.minibean.timewizard.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.dto.ChatDto;

@Repository //Dao
public class ChatDaoImpl implements ChatDao{
	
	@Autowired
	private SqlSession sqlsession;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	ChatDto dto;


	@Override
	public void init() {
		// TODO Auto-generated method stub
		
	}


	@Override
	public List<ChatDto> selectList() {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public ChatDto selectOne(String user_id) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public ChatDto Insert(String user_id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
