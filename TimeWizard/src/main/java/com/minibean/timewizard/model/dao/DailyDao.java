package com.minibean.timewizard.model.dao;

import java.util.List;

import com.minibean.timewizard.model.dto.DailyDto;

public interface DailyDao {
	
	String NAMESPACE="";
	
	public List<DailyDto> selectList();

}
