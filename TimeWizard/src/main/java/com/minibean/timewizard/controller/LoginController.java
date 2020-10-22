package com.minibean.timewizard.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.utils.LoginGoogleVO;
import com.minibean.timewizard.utils.LoginNaverVO;

@Controller
@RequestMapping(value="/login")
public class LoginController {
	
	@Autowired
	private UserInfoBiz userInfoBiz;
	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginNaverVO loginNaverVO;
	@Autowired
	private LoginGoogleVO loginGoogleVO;
	private String apiResult = null;
	
	@Autowired
	private void setLoginNaverVO(LoginNaverVO loginNaverVO) {
		this.loginNaverVO = loginNaverVO;
	}
	
	
	/* 기본 로그인창 */
	@RequestMapping(value="loginform", method= {RequestMethod.GET, RequestMethod.POST})
	public String loginPage(Model model, HttpSession session) {
		logger.info(">> [CONTROLLER-USERINFO] move to login page");
		
		String naverAuthUrl = loginNaverVO.getAuthorizationUrl(session);
		String googleAuthUrl = loginGoogleVO.getAuthorizationUrl(session);
		model.addAttribute("naver_url", naverAuthUrl);
		model.addAttribute("google_url", googleAuthUrl);
//		model.addAttribute("kakao_url", "");
		logger.info("* naver: " + naverAuthUrl);
		logger.info("* google: " + googleAuthUrl);
		
		return "userlogin";
	}
	
	/* 일반 로그인 : 일반 로그인 ID 혹은 PW를 입력하지 않았거나 틀렸을 때 (userlogin.jsp의 javascript와 연결) */
	@RequestMapping(value="/ajaxlogin", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> ajaxLogin(@RequestBody UserInfoDto dto, HttpSession session){
		logger.info("[ajaxlogin]");
		
		UserInfoDto res = userInfoBiz.selectOne(dto);
		
		boolean check = false;
		if (res != null) {
			// 로그인 값을 계속 가지고 있는 Session
			session.setAttribute("login", res);
			check = true;
		}
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("check", check);
		
		return map;
	}
	
	/* 일반 로그인에서 아이디/PW를 맞게 입력했을 때 넘어감 */
	@RequestMapping(value="/success")
	public String success(UserInfoDto dto, HttpSession session) {
		
		return "redirect:../success";	
	}
	
	/* sns 로그인 - NAVER */
	@RequestMapping(value="/navercallback", method= {RequestMethod.GET, RequestMethod.POST})
	public String navercallback(@RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, InterruptedException, ExecutionException {
		
		logger.info(">> [CONTROLLER-USERINFO] NAVER callback ");
		
		OAuth2AccessToken oauthToken = loginNaverVO.getAccessToken(session, code, state);
		apiResult = loginNaverVO.getUserProfile(oauthToken);
		
		JsonObject object = JsonParser.parseString(apiResult).getAsJsonObject().get("response").getAsJsonObject();
		
		UserInfoDto naverdto = new UserInfoDto();
		naverdto.setUser_id(object.get("id").toString().split("\"")[1]);
		naverdto.setUser_pw("naver"); // 해당 부분 수정 바람
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
	
	/* sns 로그인 - GOOGLE */
	@RequestMapping(value="/googlecallback", method= {RequestMethod.GET, RequestMethod.POST})
	public String googlecallback(@RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, InterruptedException, ExecutionException {
		logger.info(">> [CONTROLLER-USERINFO] GOOGLE callback");
		OAuth2AccessToken oauthToken = loginGoogleVO.getAccessToken(session, code, state);
		apiResult = loginGoogleVO.getUserProfile(oauthToken);
//		logger.info("* api result : " + apiResult);
		
		JsonObject object = JsonParser.parseString(apiResult).getAsJsonObject();
		UserInfoDto googledto = new UserInfoDto();
		googledto.setUser_id(object.get("sub").toString().split("\"")[1]);
		googledto.setUser_pw("google"); // 해당 부분 수정 바람
		googledto.setUser_email(object.get("email").toString().split("\"")[1]);
		googledto.setUser_name(object.get("name").toString().split("\"")[1]);
		
		UserInfoDto result = userInfoBiz.selectOne(googledto);
		if (result == null) {
			session.setAttribute("snsinfo", googledto);
			return "redirect:./snssignup";
		} else {
			session.setAttribute("login", result);
			return "redirect:../success";
		}
	}
	
	/* sns 회원가입 */
	@RequestMapping(value="/snssignup")
	public String signupPageSns(Model model, UserInfoDto dto) {
		logger.info(">> [CONTROLLER-USERINFO] move to user signup form (SNS)");
		
		return "usersignupsns";
	}
	
	/* 일반 회원가입 */
	@RequestMapping(value="/signup")
	public String signupPage() {
		logger.info(">> [CONTROLLER-USERINFO] move to user signup form");
		
		return "usersignup";
	}
	
	/* 회원가입 완료 */
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
