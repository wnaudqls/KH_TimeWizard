package com.minibean.timewizard.model.dao;

import java.util.List;

import com.minibean.timewizard.model.dto.UserTodoDto;

public interface UserTodoDao {
	
	String NAMESPACE="com.minibean.timewizard.usertodo.";
	
	public List<UserTodoDto> selectList(); // user_no 필요함...
	public UserTodoDto selectOne(int todo_no);
	public int insert(UserTodoDto dto);
	public int update(UserTodoDto dto);
	public int delete(int todo_no);

}
