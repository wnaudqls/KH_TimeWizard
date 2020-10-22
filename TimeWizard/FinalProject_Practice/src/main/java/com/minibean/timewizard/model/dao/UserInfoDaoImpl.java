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
public class UserInfoDaoImpl  implements UserInfoDao{
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	Logger logger = LoggerFactory.getLogger(UserInfoDaoImpl.class);

	@Override
	public List<UserInfoDto> selectList() {
		
		logger.info(">> [USERINFO] selectList");
		
		List<UserInfoDto> list = new ArrayList<UserInfoDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"selectList");
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: selectList");
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public UserInfoDto login(UserInfoDto dto) {
		
		UserInfoDto result = null;
		try {
			result = sqlSession.selectOne(NAMESPACE+"login",dto);
		} catch (Exception e) {
			logger.info(" [ Error 유형 ] : Login");
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int insert(UserInfoDto dto) {
		int res = 0;
		
		try {
			res= sqlSession.insert(NAMESPACE+"insert",dto);
		} catch (Exception e) {
			logger.info(" [Error 유형 ] : Insert(회원가입)");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int idCheck(String user_id) {
		int cnt= sqlSession.selectOne(NAMESPACE+"idcheck", user_id);
		return cnt;
	}


	/*
	 *  UserInfoDto idCheck(String user_id) { UserInfoDto dto = null;
	 * public
	 * try { dto = sqlSession.selectOne(NAMESPACE+"idcheck",user_id); } catch
	 * (Exception e) { logger.info(" [Error 유형 ] : Id Check "); e.printStackTrace();
	 * }
	 * 
	 * return dto; }
	 */


}
