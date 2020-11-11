package com.minibean.timewizard.model.dao;

import java.util.List;

import com.minibean.timewizard.model.dto.FileUploadDto;

public interface FileUploadDao {

	String NAMESPACE="com.minibean.timewizard.fileupload.";
	
	public List<FileUploadDto> selectList(int user_no);
	public FileUploadDto selectOne(int file_no);
	public int insert(FileUploadDto dto);
	
}
