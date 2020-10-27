package com.mvc.security.model.dao;

import com.mvc.security.model.dto.MemberDto;

public interface MemberDao {
	String NAMESPACE = "com.minibean.timewizard.security.";
	
	public MemberDto login(MemberDto dto);
	public int regist(MemberDto dto);
}
