package com.minibean.timewizard.model.biz;

import java.util.HashMap;
import java.util.List;

import com.minibean.timewizard.model.dto.UserTodoDto;

public interface UserTodoBiz {
	
	public List<UserTodoDto> selectList(int user_no);
	public List<UserTodoDto> selectList(HashMap<String, Object> params);
	public int countList(int user_no);
	public UserTodoDto selectOne(int todo_no);
	public int insert(UserTodoDto dto);
	public int insertExample(int user_no);
	public int update(UserTodoDto dto);
	public int delete(int todo_no);

}
