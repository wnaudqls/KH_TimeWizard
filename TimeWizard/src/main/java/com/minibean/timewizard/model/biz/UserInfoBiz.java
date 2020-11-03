package com.minibean.timewizard.model.biz;

import java.util.List;

import com.minibean.timewizard.model.dto.UserInfoDto;

public interface UserInfoBiz {
	
	public List<UserInfoDto> selectList();
	public UserInfoDto selectOne(int user_no); /* session용 */
	public UserInfoDto selectOne(UserInfoDto dto); /* 기타용 */
	public int insert(UserInfoDto dto);
	public int update(UserInfoDto dto);
	public int delete(int user_no);
	public int idCheck(String id);//아이디 중복체크 용도
	

	
}
