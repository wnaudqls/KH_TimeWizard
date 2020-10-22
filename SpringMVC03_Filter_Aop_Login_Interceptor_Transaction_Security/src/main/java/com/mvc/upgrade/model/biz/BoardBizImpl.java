package com.mvc.upgrade.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mvc.upgrade.model.dao.BoardDao;
import com.mvc.upgrade.model.dto.BoardDto;

// bean을 Biz로 등록해준다? / Component와 큰 차이가 없음
@Service
public class BoardBizImpl implements BoardBiz {
	
	@Autowired
	public BoardDao boardDao;
	
	@Override
	public List<BoardDto> selectList() {
		return boardDao.selectList();
	}

	@Override
	public BoardDto selectOne(int myno) {
		return boardDao.selectOne(myno);
	}

	@Override
	public int insert(BoardDto dto) {
		return boardDao.insert(dto);
	}

	@Override
	public int update(BoardDto dto) {
		return boardDao.update(dto);
	}

	@Override
	public int delete(int myno) {
		return boardDao.delete(myno);
	}
	
	@Transactional
	@Override
	public String transactionTest() {
		boardDao.insert(new BoardDto(0, "transaction", "test", "insert", null));
		
		String test = boardDao.test();
		// NullPinterException Error 발생
		test.length();
		
		return test;
	}

}





















