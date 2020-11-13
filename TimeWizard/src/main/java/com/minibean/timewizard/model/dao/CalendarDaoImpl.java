package com.minibean.timewizard.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.CalendarDto;

@Repository
public class CalendarDaoImpl implements CalendarDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	Logger logger = LoggerFactory.getLogger(CalendarDaoImpl.class);
	
	public int insertCalBoard(CalendarDto dto) {
		logger.info(" < Calendar Insert > ");
		int res = 0;
		
		try {
			res =sqlSession.insert(NAMESPACE+"insertCalBoard",dto);
		} catch (Exception e) {
			logger.info(" [ Error : Calendar Insert ");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<CalendarDto> getCalList(int user_no, String yyyymmdd) {
		logger.info(" < getCalendarList > ");
		List<CalendarDto>list = new ArrayList<CalendarDto>();
		Map<Object, Object>map = new HashMap<Object, Object>();
		map.put("user_no",user_no);
		map.put("yyyymmdd", yyyymmdd);
	
		try {
			list =sqlSession.selectList(NAMESPACE+"getCalList",map);
		} catch (Exception e) {
			logger.info(" [ Error : getCalendarList ] ");
			e.printStackTrace();
		}
		
		
		return list;
	}

	@Override
	public List<CalendarDto> getViewList(int user_no, String yyyyMM) {
		
		logger.info(" < getViewList > ");
		List<CalendarDto>list = new ArrayList<CalendarDto>();
		Map<Object, Object>map = new HashMap<Object, Object>();
		
		map.put("user_no",user_no);
		map.put("yyyyMM", yyyyMM);
		logger.info(" ***********************************************값이 들어오는지 확인: "+map);
		
		
		try {
			list = sqlSession.selectList(NAMESPACE+"getViewList",map);
		} catch (Exception e) {
			logger.info(" [ Error : getViewList ] ");
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int getViewCount(int user_no, String yyyyMMdd) {
		logger.info(" < getVieWCount > ");
		Map<Object, Object>map = new HashMap<Object, Object>();
		map.put("user_no",user_no);
		map.put("yyyyMMdd",yyyyMMdd);
		
		int count = 0;
		try {
			count= sqlSession.insert(NAMESPACE+"getViewCount",map);
		} catch (Exception e) {
			logger.info(" [ Error : getViewCount ] ");
			e.printStackTrace();
		}
		
		return count;
	}

	
}
