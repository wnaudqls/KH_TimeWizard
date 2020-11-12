package com.minibean.timewizard.controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class IdPwFindController {
	
	@Autowired
	private UserInfoBiz userinfoBiz;
	
	private Logger logger = LoggerFactory.getLogger(IdPwFindController.class);

	@RequestMapping(value="/findform")
	public String gofindpage() {
		logger.info("idpw_find controller");
		return "idpw_find";
	}
	
	//아이디 찾기
	//이름, 이메일
	@RequestMapping("/findID")
	public UserInfoDto findID(@RequestParam("user_name")String user_name,
						@RequestParam("user_email")String user_email) {
		logger.info("[findID Controller]");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_name",user_name);
		map.put("user_email", user_email);
		UserInfoDto dto = userinfoBiz.findID(map);
		
		return dto;
	}
	
	
	//비밀번호 찾기
	//이름, 이메일, 아이디
	//@RequestMapping("/")
	
}
