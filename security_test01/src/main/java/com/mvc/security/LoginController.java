package com.mvc.security;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	
	@RequestMapping(value = "/login/loginForm.do",method = RequestMethod.GET)
	public String loginFor(Locale locale, Model model) {
		logger.info("로그인컨트롤러 ");
		return "login/loginForm";
	}
	@RequestMapping(value = "/login/accessDenied.do", method = RequestMethod.GET)
	public String accessDenied(Locale locale, Model model) {
		logger.info("accessDenied컨트롤러");
		
		return "login/accessDenied";
		
	}
	
}
