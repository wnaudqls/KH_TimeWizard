package com.minibean.timewizard.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.UserInfoDao;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Service
public class UserInfoBizImpl implements UserInfoBiz{

	@Autowired
	private UserInfoDao userInfoDao;

	@Override
	public List<UserInfoDto> selectList() {
		
		return userInfoDao.selectList();
	}

	@Override
	public UserInfoDto login(UserInfoDto dto) {
		
		return userInfoDao.login(dto);
	}

	@Override
	public int insert(UserInfoDto dto) {
		
		return userInfoDao.insert(dto);
	}

	@Override
	public int idCheck(String id) {
		
		return userInfoDao.idCheck(id);
	}

	/*
	 * @Override public UserInfoDto idCheck(String user_id) {
	 * 
	 * return userInfoDao.idCheck(user_id); }
	 */

	
	
	
	
	
}
