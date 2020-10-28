package com.minibean.timewizard.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.UserInfoDao;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Service
public class UserInfoBizImpl implements UserInfoBiz {

	@Autowired
	private UserInfoDao userInfoDao;
	
	@Override
	public List<UserInfoDto> selectList() {
		return userInfoDao.selectList();
	}

	@Override
	public UserInfoDto selectOne(int user_no) {
		return userInfoDao.selectOne(user_no);
	}

	@Override
	public UserInfoDto selectOne(UserInfoDto dto) {
		return userInfoDao.selectOne(dto);
	}

	@Override
	public int insert(UserInfoDto dto) {
		return userInfoDao.insert(dto);
	}

	@Override
	public int update(UserInfoDto dto) {
		return userInfoDao.update(dto);
	}

	@Override
	public int delete(int user_no) {
		return userInfoDao.delete(user_no);
	}
	
	@Override
	public int idCheck(String id) {
		
		int cnt= userInfoDao.idCheck(id);
		return cnt;
	}

}
