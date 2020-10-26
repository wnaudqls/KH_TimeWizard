package com.minibean.timewizard.model.dao;

import java.util.HashMap;
import java.util.List;

import com.minibean.timewizard.model.dto.UserTodoDto;

public interface UserTodoDao {
	
	String NAMESPACE="com.minibean.timewizard.usertodo.";
	
	public List<UserTodoDto> selectList(int user_no);
	public List<UserTodoDto> selectList(HashMap<String, Object> params); // user_no 필요함...
	public UserTodoDto selectOne(int todo_no);
	public int insert(UserTodoDto dto);
	public int insertExample();
	public int update(UserTodoDto dto);
	public int delete(int todo_no);

}
