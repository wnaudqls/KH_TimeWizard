package com.mvc.update.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvc.update.model.dao.JDBCDao;
import com.mvc.update.model.dto.JDBCDto;

@Service
public class JDBCBizImpl implements JDBCBiz {
	
	@Autowired
	private JDBCDao jdbcDao;

	@Override
	public List<JDBCDto> selectList() {
		return jdbcDao.selectList();
	}

	@Override
	public JDBCDto selectOne(int seq) {
		return jdbcDao.selectOne(seq);
	}

	@Override
	public int insert(JDBCDto dto) {
		return jdbcDao.insert(dto);
	}

	@Override
	public int update(JDBCDto dto) {
		return jdbcDao.update(dto);
	}

	@Override
	public int delete(int seq) {
		return jdbcDao.delete(seq);
	}

	@Override
	public String transactionTest() {
		return null;
	}

}
