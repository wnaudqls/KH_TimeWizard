package com.minibean.timewizard.model.dao;

import java.util.List;

import com.minibean.timewizard.model.dto.NoticeDto;
import com.minibean.timewizard.model.dto.UserTodoDto;

public interface NoticeDao {
	
	String NAMESPACE = "com.minibean.timewizard.notice.";
	
	public List<NoticeDto> selectList();
	public NoticeDto selectOne(int notice_no);
	public int insert(NoticeDto dto);
	public int update(NoticeDto dto);
	public int delete(int notice_no);

}
