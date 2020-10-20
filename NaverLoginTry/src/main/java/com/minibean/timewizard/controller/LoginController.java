package com.minibean.timewizard.controller;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.utils.LoginNaverVO;

@Controller
@RequestMapping(value="/login")
public class LoginController {
	
	@Autowired
	private UserInfoBiz userInfoBiz;
	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginNaverVO loginNaverBO;
	private String apiResult = null;
	
	@Autowired
	private void setLoginNaverBO(LoginNaverVO loginNaverBO) {
		this.loginNaverBO = loginNaverBO;
	}
	
	@RequestMapping(value="", method= {RequestMethod.GET, RequestMethod.POST})
	public String loginPage(Model model, HttpSession session) {
		logger.info(">> [CONTROLLER-USERINFO] move to login page");
		
		String naverAuthUrl = loginNaverBO.getAuthorizationUrl(session);
		model.addAttribute("naver_url", naverAuthUrl);
		logger.info("* naver: " + naverAuthUrl);
		
		return "userlogin";
	}
	
	@RequestMapping(value="/general", method= {RequestMethod.GET, RequestMethod.POST})
	public String generalLogin(UserInfoDto dto, HttpSession session) {
		logger.info(">> [CONTROLLER-USERINFO] general login");
		
		UserInfoDto result = null;
		try {
			result = userInfoBiz.selectOne(dto);
			session.setAttribute("login", result);
			return "redirect:../success";
		} catch (Exception e) {
			logger.info("[ERROR] CONTROLLER-USERINFO :: general login");
			e.printStackTrace();
		}
		return "redirect:../";
	}
	
	@RequestMapping(value="/navercallback", method= {RequestMethod.GET, RequestMethod.POST})
	public String navercallback(@RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, InterruptedException, ExecutionException {
		
		logger.info(">> [CONTROLLER-USERINFO] NAVER callback ");
		
		OAuth2AccessToken oauthToken = loginNaverBO.getAccessToken(session, code, state);
		apiResult = loginNaverBO.getUserProfile(oauthToken);
		
		JsonObject object = JsonParser.parseString(apiResult).getAsJsonObject().get("response").getAsJsonObject();
		
		UserInfoDto naverdto = new UserInfoDto();
//		System.out.println(object.get("id").toString().split("\"")[1]);
		// "id" 식으로 가져온다!
		
		naverdto.setUser_id(object.get("id").toString().split("\"")[1]);
		naverdto.setUser_pw("naver");
		naverdto.setUser_email(object.get("email").toString().split("\"")[1]);
		naverdto.setUser_name(object.get("name").toString().split("\"")[1]);
		
		UserInfoDto result = userInfoBiz.selectOne(naverdto);
		if (result == null) {
			session.setAttribute("snsinfo", naverdto);
			return "redirect:./snssignup";
		} else {
			session.setAttribute("login", result);
			return "redirect:../success";
		}
	}
	
	
	@RequestMapping(value="/signup")
	public String signupPage() {
		logger.info(">> [CONTROLLER-USERINFO] move to user signup form");
		
		return "usersignup";
	}
	
	@RequestMapping(value="/snssignup")
	public String signupPageSns(Model model, UserInfoDto dto) {
		logger.info(">> [CONTROLLER-USERINFO] move to user signup form (SNS)");
		
		return "usersignupsns";
	}
	
	@RequestMapping(value="/signupresult")
	public String signupResult(UserInfoDto dto) {
		logger.info(">> [CONTROLLER-USERINFO] signup");
		
		int res = userInfoBiz.insert(dto);
		if (res > 0) {
			return "redirect:../login";
		} else {
			logger.info("[ERROR] CONTROLLER-USERINFO :: signup form");
			return "redirect:../login";
		}
		
	}
	
}
