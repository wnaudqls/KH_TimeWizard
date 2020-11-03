package com.minibean.timewizard.controller;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {
	
	@Autowired
	private int user_no;
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_email;
	private String user_role;
	private String user_photo;
	private String user_active;
	private Date user_regdate;
	
	private Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@RequestMapping("/adminpage")
	public String Mypage() {
		logger.info("[adminpage]");
		return "adminpage";
	}
	
	// 회원 정보 조회
	
	
	// 회원 등급 변경

}
