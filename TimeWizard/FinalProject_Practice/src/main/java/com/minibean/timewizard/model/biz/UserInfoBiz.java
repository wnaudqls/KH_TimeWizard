package com.minibean.timewizard.model.biz;

import java.util.List;

import com.minibean.timewizard.model.dto.UserInfoDto;

public interface UserInfoBiz {

	public List<UserInfoDto>selectList();
	public UserInfoDto login(UserInfoDto dto);
	public int insert(UserInfoDto dto);
	
	public int idCheck(String id);
}
