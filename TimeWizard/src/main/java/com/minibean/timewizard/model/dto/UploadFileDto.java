package com.minibean.timewizard.model.dto;
import org.springframework.web.multipart.MultipartFile;

public class UploadFileDto {
	
	private int user_no;
	private String file_title;
	private MultipartFile profile;
	
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getFile_title() {
		return file_title;
	}
	public void setFile_title(String file_title) {
		this.file_title = file_title;
	}
	public MultipartFile getProfile() {
		return profile;
	}
	public void setProfile(MultipartFile profile) {
		this.profile = profile;
	}
}
