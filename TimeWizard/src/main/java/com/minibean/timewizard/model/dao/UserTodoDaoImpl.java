package com.minibean.timewizard.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.UserTodoDto;

@Repository
public class UserTodoDaoImpl implements UserTodoDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private Logger logger = LoggerFactory.getLogger(UserTodoDaoImpl.class);
	
	@Override
	public List<UserTodoDto> selectList() {
		List<UserTodoDto> list = new ArrayList<UserTodoDto>();
		
		
		
		return null;
	}

}
