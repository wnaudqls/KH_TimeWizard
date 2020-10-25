package com.minibean.timewizard.model.biz;

import java.util.List;

import com.minibean.timewizard.model.dto.UserTodoDto;

public interface UserTodoBiz {
	
	
	public List<UserTodoDto> selectList();

}
