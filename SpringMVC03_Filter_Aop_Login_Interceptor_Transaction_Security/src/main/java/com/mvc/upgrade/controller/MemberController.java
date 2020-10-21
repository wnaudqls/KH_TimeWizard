package com.mvc.upgrade.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mvc.upgrade.model.biz.MemberBiz;
import com.mvc.upgrade.model.dto.MemberDto;

@Controller
public class MemberController {
	
	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberBiz memberBiz;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping("/loginform.do")
	public String loginForm() {
		logger.info("[loginform.do]");
		
		return "mvclogin";
	}
	
	@RequestMapping("/ajaxlogin.do")
	@ResponseBody // ViewResolver를 통하지않고 응답해주기 위한 어노테이션
	public Map<String, Boolean> ajaxLogin(@RequestBody MemberDto dto, HttpSession session) {
		logger.info("[ajaxlogin.do]");
		
		MemberDto result = memberBiz.login(dto);
		
		boolean check = false;
		if (result != null) {
			// rawPassword : 사용자가 입력한 패스워드 값, encodedPassword : db에 암호화되어 저장된 패스워드 값
			if (passwordEncoder.matches(dto.getMemberpw(), result.getMemberpw())) {
				logger.info("사용자가 전달한 memberpw : " + dto.getMemberpw());
				logger.info("db에 암호화되어 저장된 memberpw : " + result.getMemberpw());
				session.setAttribute("login", result);
				check = true;
			}
		}
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("check", check);
		
		return map;
	}
	
	@RequestMapping("/registform.do")
	public String registForm() {
		logger.info("[registform.do]");
		
		return "mvcregist";
	}
	
	@RequestMapping("/registres.do")
	public String registRes(MemberDto dto) {
		logger.info("[registres.do]");
		
		// 비밀번호 암호화
		dto.setMemberpw(passwordEncoder.encode(dto.getMemberpw()));
		logger.info("암호화 된 memberpw : " + dto.getMemberpw());
		
		if (memberBiz.insert(dto) > 0) {
			return "redirect:loginform.do";
		}
		
		return "redirect:registform.do";
	}
	
	@RequestMapping("/testform.do")
	public String testForm() {
		logger.info("[testform.do]");
		
		return "mvctest";
	}
	
}


























