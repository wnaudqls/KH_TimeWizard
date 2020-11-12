package com.minibean.timewizard.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.minibean.timewizard.model.biz.UserInfoBiz;

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
	//@RequestMapping("/")
	
	
	//비밀번호 찾기
	//이름, 이메일, 아이디
	//@RequestMapping("/")
	
}
