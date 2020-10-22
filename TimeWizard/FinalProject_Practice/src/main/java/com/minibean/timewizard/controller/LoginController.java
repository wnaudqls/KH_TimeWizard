package com.minibean.timewizard.controller;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dao.UserInfoDao;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class LoginController {

	@Autowired
	private UserInfoBiz userInfoBiz;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	Logger logger =  LoggerFactory.getLogger(LoginController.class);
	
	@RequestMapping("/signup.do")
	public String signUp() {
	
		logger.info(" [ Sign Up ] ");
		return "usersignup";
	}
	

	@RequestMapping("/signupres.do")
	public String signUpRes(UserInfoDto dto) {
		dto.setUser_pw(passwordEncoder.encode(dto.getUser_pw()));
		logger.info("암호화 된 유저 패스워드 : "+dto.getUser_pw());
		if(userInfoBiz.insert(dto)>0) {
			return "redirect:loginform.do";
		}
		
		return "redirect:signup.do";
	
	}
	
	
	@RequestMapping(value="/idcheck.do" ,method = RequestMethod.GET)
	public @ResponseBody int idCheck(@RequestParam("user_id")String user_id) {
		logger.info(" 입력받은 아이디 : "+user_id);
		int cnt=userInfoBiz.idCheck(user_id);
		
		return cnt;
    }



	
}
