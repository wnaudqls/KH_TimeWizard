package com.minibean.timewizard.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.UserInfoDto;

@Repository
public class UserInfoDaoImpl implements UserInfoDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final Logger logger = LoggerFactory.getLogger(UserInfoDaoImpl.class);
	
	@Override
	public List<UserInfoDto> selectList() {
		logger.info(">> [USERINFO] selectList");
		
		List<UserInfoDto> result = new ArrayList<UserInfoDto>();
		try {
			result = sqlSession.selectList(NAMESPACE+"selectList");
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: selectList");
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public UserInfoDto selectOne(int user_no) {
		logger.info(">> [USERINFO] selectOne by user_no - " + user_no);
		UserInfoDto result = null;
		
		try {
			result = sqlSession.selectOne(NAMESPACE+"selectOneUserNo", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: selectOne by user_no");
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public UserInfoDto selectOne(UserInfoDto dto) {
		logger.info(">> [USERINFO] selectOne by UserInfoDto - " + dto.getUser_no());
		UserInfoDto result = null;
		
		try {
			result = sqlSession.selectOne(NAMESPACE+"selectOneUserInfoDto", dto);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: selectOne by UserInfoDto");
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int insert(UserInfoDto dto) {
		logger.info(">> [USERINFO] insert");
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"insert", dto);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: insert");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int update(UserInfoDto dto) {
		logger.info(">> [USERINFO] update : user_no - " + dto.getUser_no());
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"update", dto);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: update");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int delete(int user_no) {
		logger.info(">> [USERINFO] user unscribe");
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"delete", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: unscribe");
			e.printStackTrace();
		}
		
		return res;
	}

}
