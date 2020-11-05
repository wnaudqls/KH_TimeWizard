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
import org.springframework.web.bind.annotation.ResponseBody;

import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class AdminController {
	
	private Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private UserInfoBiz userinfoBiz;
	
	@RequestMapping(value="/adminpage")
	public String adminPage(Model model) {
		logger.info("[adminpage]");
		
		model.addAttribute("list", userinfoBiz.selectList());
		
		return "adminpage";
	}
	
	// 관리자페이지에서 등급변경 버튼 누르면 등급변경 페이지로 이동
	@RequestMapping(value="/adminrole")
	public String adminRole(Model model, @RequestParam int user_no) {
		logger.info("[admin role change]");

		model.addAttribute("dto", userinfoBiz.selectOne(user_no));
		
		return "adminrole";
	}
	
	@RequestMapping(value="/adminroleres")
	public String adminRoleRes(UserInfoDto dto, UserInfoDto user_no, @RequestParam String user_role) {
		logger.info("[admin role change result]");
		logger.info("user_role : " + user_role);
		logger.info("dto :"+ dto);
		
		// controller에서 해당 user_no를 받아서 해당 유저 dto 객체 생성하기
		// dto = userinfoBiz.selectOne(user_no);
		// controller에서 생성한 객체 dto에 setUser_role(String user_role)을 넣어 변경해주기
		// dto.setUser_role(user_role);
		// 그렇게 갱신된 객체 dto를 update(dto)해주기
		
		int res = userinfoBiz.updateRoleRes(dto);
		
		// update가 돌아 리턴된 integer 값을 받아서 logger.info 찍어주기
		logger.info("res : "+res);

		if(res != 0) {
			System.out.println("등급 변경 성공");
		} else {
			System.out.println("등급 변경 실패");
		}
		
		return "redirect:adminpage?user_role="+dto.getUser_role();
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
	

