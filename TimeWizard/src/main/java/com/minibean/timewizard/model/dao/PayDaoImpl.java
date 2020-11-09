package com.minibean.timewizard.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.PayDto;

@Repository
public class PayDaoImpl implements PayDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final Logger logger = LoggerFactory.getLogger(PayDaoImpl.class);

	
	@Override
	public List<PayDto> selectList() {
		logger.info("pay selectList daoimple ");
		List<PayDto> list = new ArrayList<PayDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"PayselectList");
		} catch (Exception e) {
			logger.info("[ERROR] pay selectList daoimpl");
			e.printStackTrace();
		}
		return list;
	}
	
	
	@Override
	public PayDto selectOne(int user_no) {
		logger.info("pay selectOne daoimple - "+user_no);
		PayDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"PayselectOne", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] pay selectOne daoimpl");
			e.printStackTrace();
		}
		
		return dto;
	}


}
