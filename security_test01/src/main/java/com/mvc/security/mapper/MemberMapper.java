package com.mvc.security.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mvc.security.model.dto.MemberDto;

@Mapper
public interface MemberMapper {
	
	public MemberDto login(MemberDto dto);
	public int regist(MemberDto dto);

}
