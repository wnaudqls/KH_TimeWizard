package com.mvc.security.model.biz;

import com.mvc.security.model.dto.MemberDto;

public interface MemberBiz {
	
	public MemberDto login(MemberDto dto);
	public int regist(MemberDto dto);

}
