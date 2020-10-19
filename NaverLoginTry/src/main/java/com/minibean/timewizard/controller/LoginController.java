package com.minibean.timewizard.controller;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.minibean.timewizard.utils.LoginNaverBO;

@Controller
@RequestMapping(value="/login")
public class LoginController {
	
	@Autowired
	private LoginNaverBO loginNaverBO;
	private String apiResult = null;
	
	@Autowired
	private void setLoginNaverBO(LoginNaverBO loginNaverBO) {
		this.loginNaverBO = loginNaverBO;
	}

	@RequestMapping(value="", method= {RequestMethod.GET, RequestMethod.POST})
	public String loginpage(Model model, HttpSession session) {
		String naverAuthUrl = loginNaverBO.getAuthorizationUrl(session);
		model.addAttribute("naver_url", naverAuthUrl);
		System.out.println("* naver: " + naverAuthUrl);
		return "userlogin";
	}
	
	
	@RequestMapping(value="/navercallback", method= {RequestMethod.GET, RequestMethod.POST})
	public String navercallback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, InterruptedException, ExecutionException {
		
		System.out.println(">> callback");
		OAuth2AccessToken oauthToken = loginNaverBO.getAccessToken(session, code, state);
		apiResult = loginNaverBO.getUserProfile(oauthToken);
		System.out.println(apiResult);
		model.addAttribute("result", apiResult);
		return "naversuccess";
	}
	
	
}
