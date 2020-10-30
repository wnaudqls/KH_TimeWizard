package com.minibean.timewizard.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.FriendDao;
import com.minibean.timewizard.model.dto.FriendDto;

@Service
public class FriendBizImpl implements FriendBiz {
	
	@Autowired
	private FriendDao friendDao;

	@Override
	public List<FriendDto> selectListF(int user_no) {
	
		return friendDao.selectListF(user_no);
	}

	@Override
	public List<FriendDto> selectListN(int user_no) {
		
		return friendDao.selectListN(user_no);
	}

}
