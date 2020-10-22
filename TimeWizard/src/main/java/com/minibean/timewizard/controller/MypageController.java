package com.minibean.timewizard.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MypageController {
	
	private Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@RequestMapping("/mypage")
	public String Mypage() {
		
		return "mypage";
	}

}
