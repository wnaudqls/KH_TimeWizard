package com.minibean.timewizard.utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.aspectj.apache.bcel.classfile.annotation.NameValuePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

@Component
public class LoginKakaoVO {

	private final static String CLIENT_ID = "f2bb69c087395a1c32609e8290b1f4e6";
//	private final static String CLIENT_SECRET = "NvBxnmvoWi2ivjRQAhqZX53FaPBFrBfb";
	private final static String REDIRECT_URI = "http://localhost:8787/timewizard/login/kakaocallback";
	private final static String PROTECTED_RESOURCE_URL = "https://kapi.kakao.com/v2/user/me";
	private final static String SCOPE = "profile account_email";
	private final static String SESSION_STATE = "oauth_state_k";
	
	private Logger logger = LoggerFactory.getLogger(LoginKakaoVO.class);

	public String getAuthorizationUrl(HttpSession session) {
		String state = generateRandomString();
		setSession(session, state);
		OAuth20Service oauthService = new ServiceBuilder(CLIENT_ID)
				.callback(REDIRECT_URI)
				.build(LoginKakaoApi.instance());
//				.apiSecret(CLIENT_SECRET)
		return oauthService.getAuthorizationUrl(state);
	}
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException, InterruptedException, ExecutionException {
		String sessionState = getSession(session);
		logger.info("* state : " + state + "\n* session state " + sessionState);
		if (StringUtils.pathEquals(sessionState, state)) {
			OAuth20Service oauthService = new ServiceBuilder(CLIENT_ID)
					.callback(REDIRECT_URI)
					.build(LoginKakaoApi.instance());
//					.apiSecret(CLIENT_SECRET)
			return oauthService.getAccessToken(code);
		}
		return null;
	}
	public String getUserProfile(OAuth2AccessToken accessToken) throws InterruptedException, ExecutionException, IOException {
		OAuth20Service oauthService = new ServiceBuilder(CLIENT_ID)
				.callback(REDIRECT_URI)
				.build(LoginKakaoApi.instance());
//		.apiSecret(CLIENT_SECRET)
		OAuthRequest request = new OAuthRequest(Verb.GET, PROTECTED_RESOURCE_URL);
		oauthService.signRequest(accessToken, request);
		Response response = oauthService.execute(request);
		logger.info(response.getBody());
		return response.getBody();
	};	
	
	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}
	
	private void setSession(HttpSession session, String state) {
		session.setAttribute(SESSION_STATE, state);
	}
	
	private String getSession(HttpSession session) {
		return (String) session.getAttribute(SESSION_STATE);
	}
	
}
