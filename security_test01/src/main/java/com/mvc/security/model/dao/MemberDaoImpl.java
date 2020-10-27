package com.mvc.security.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvc.security.model.dto.MemberDto;

@Service
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final Logger logger = LoggerFactory.getLogger(MemberDaoImpl.class);
	

	@Override
	public MemberDto login(MemberDto dto) {
		logger.info("[login컨트롤러]");
		
		MemberDto mdto = null;
		
		try {
			mdto = sqlSession.selectOne(NAMESPACE+"login",dto);
		} catch (Exception e) {
			logger.info("[ERROR]loginDao");
			e.printStackTrace();
		}
		
		return mdto;
	}

	@Override
	public int regist(MemberDto dto) {
		logger.info("[regist컨트롤러]");
		
		return 0;
	}

}
