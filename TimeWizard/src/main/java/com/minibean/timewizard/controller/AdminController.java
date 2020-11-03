package com.minibean.timewizard.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminController {
	
	private Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@RequestMapping(value="/adminpage")
	public String AdminPage() {
		logger.info("[adminpage]");
		return "adminpage";
	}
	
	// 회원 등급 변경 버튼
	@RequestMapping(value="/adminrole")
	public String AdminRole() {
		logger.info("[admin role change]");
		
		
		return "adminroleres";
	}
	
	// 회원 등급 변경 페이지
	@RequestMapping(value="/adminroleres")
	public String AdminRoleRes() {
		logger.info("[admin role change Result]");
		
		
		return "adminroleres";
	}
}
