package com.minibean.timewizard.model.biz;

import java.util.List;

import com.minibean.timewizard.model.dto.PayDto;

public interface PayBiz {
	
	public List<PayDto> selectList();
	public List<PayDto> selectOne(int user_no);

}
