package com.minibean.timewizard.model.biz;

import java.util.List;

import com.minibean.timewizard.model.dto.NoticeDto;
import com.minibean.timewizard.model.dto.PagingDto;

public interface NoticeBiz {
	
	public List<NoticeDto> selectList(PagingDto pagindto);
	public NoticeDto selectOne(int notice_no);
	public int insert(NoticeDto dto);
	public int update(NoticeDto dto);
	public int delete(int notice_no);
	
	public int countNotice(PagingDto search);

}
