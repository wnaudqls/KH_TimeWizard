package com.minibean.timewizard.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.UserTodoDao;
import com.minibean.timewizard.model.dto.UserTodoDto;

@Service
public class UserTodoBizImpl implements UserTodoBiz {

	@Autowired
	private UserTodoDao userTodoDao;
	
	@Override
	public List<UserTodoDto> selectList() {
		return userTodoDao.selectList();
	}

}
