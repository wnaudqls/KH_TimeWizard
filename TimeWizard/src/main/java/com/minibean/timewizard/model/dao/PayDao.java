package com.minibean.timewizard.model.dao;

import java.util.List;

import com.minibean.timewizard.model.dto.PayDto;

public interface PayDao {
	
	String NAMESPACE = "com.minibean.timewizard.pay.";
	
	public List<PayDto> selectList();
	public PayDto selectOne(int user_no);
	
	public int updateMembership(int user_no);
}
