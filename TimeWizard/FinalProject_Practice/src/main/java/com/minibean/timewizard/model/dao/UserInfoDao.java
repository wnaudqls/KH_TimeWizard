package com.minibean.timewizard.model.dao;

import java.util.List;

import com.minibean.timewizard.model.dto.UserInfoDto;;

public interface UserInfoDao {

	String NAMESPACE="userinfo.";
	
	public List<UserInfoDto>selectList();
	public UserInfoDto login(UserInfoDto dto);
	public int insert(UserInfoDto dto);

	public int idCheck(String id);
	

}
