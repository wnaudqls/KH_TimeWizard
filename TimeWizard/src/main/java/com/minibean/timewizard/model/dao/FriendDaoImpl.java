package com.minibean.timewizard.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.FriendDto;

@Repository
public class FriendDaoImpl implements FriendDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(FriendDaoImpl.class);

	@Override
	public List<FriendDto> selectListF(int user_no) {
		
		List<FriendDto> list = new ArrayList<FriendDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"selectListF", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] Friend SelectListF");
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<FriendDto> selectListN(int user_no) {
		
		List<FriendDto> list = new ArrayList<FriendDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"selectListN", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] Friend SelectListN");
			e.printStackTrace();
		}
		
		return list;
	}

}
