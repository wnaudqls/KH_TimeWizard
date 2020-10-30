package com.mvc.security.model.dao;

import com.mvc.security.model.dto.MemberDto;

public interface MemberDao {
	String NAMESPACE = "com.mvc.security.mapper.MemberMapper.";
	
	public MemberDto login(MemberDto dto);
	public int regist(MemberDto dto);
}
