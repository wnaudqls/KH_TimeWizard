package com.minibean.timewizard.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class AdminController {
	
	private Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private UserInfoBiz userinfoBiz;
	
	@RequestMapping(value="/adminpage")
	public String adminPage(Model model, UserInfoDto user_no) {
		logger.info("[adminpage]");
		
		model.addAttribute("list", userinfoBiz.selectList());
		// model.addAttribute("user_no", userinfoBiz.selectOne(user_no));
		
		return "adminpage";
	}
	
	// 회원 등급 변경 버튼 누르면 등급변경 페이지로 이동
	@RequestMapping(value="/adminrole")
	public String adminRole(Model model, @RequestParam int user_no) {
		logger.info("[admin role change]");

		model.addAttribute("dto", userinfoBiz.selectOne(user_no));
		
		return "adminrole";
	}
	
	/* 강제 탈퇴 버튼 누르면 강제탈퇴 페이지로 이동 */
	@RequestMapping(value="/admindelete")
	public String adminDelete(UserInfoDto dto, HttpSession session) throws Exception {
		logger.info("[admin member delete]");
		
			session.invalidate();
			logger.info("[탈퇴 실패]");
		
		return "adminpage";
	}
	
}
	

