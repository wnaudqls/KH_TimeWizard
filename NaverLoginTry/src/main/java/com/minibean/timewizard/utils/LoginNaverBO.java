package com.minibean.timewizard.utils;

import java.io.IOException;
import java.util.UUID;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

@Component
public class LoginNaverBO {

	/* 인증 요청문 구성 파라미터
	 * client_id : 애플리케이션 등록 후 발급받는 클라이언트 아이디
	 * response_type : 인증 과정에서의 구분값, code로 값이 고정
	 * redirect_uri : 네이버 로그인 인증 결과를 전달받을 콜백 URL.
	 * 				애플리케이션 등록 시 등록한 주소
	 * state : 애플리케이션이 생성한 상태 토큰
	 */
	private final static String CLIENT_ID = "4iXT347PPGkmH6OSJkN2";
	private final static String CLIENT_SECRET = "gOJT6tWDgW";
	private final static String REDIRECT_URI = "http://localhost:8787/timewizard/login/navercallback";
	private final static String SESSION_STATE = "oauth_state";
	private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";
	
	public String getAuthorizationUrl(HttpSession session) {
		
		String state = generateRandomString();
		setSession(session, state);
		OAuth20Service oauthService = new ServiceBuilder()
				.apiKey(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.state(state)
				.build(LoginNaverApi.instance());
		return oauthService.getAuthorizationUrl();
	}
	
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException, InterruptedException, ExecutionException {
		String sessionState = getSession(session);
		if(StringUtils.pathEquals(sessionState, state)) {
			OAuth20Service oauthService = new ServiceBuilder()
					.apiKey(CLIENT_ID)
					.apiSecret(CLIENT_SECRET)
					.callback(REDIRECT_URI)
					.state(state)
					.build(LoginNaverApi.instance());
			OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
			return accessToken;
		}
		return null;
	}
	
	public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException, InterruptedException, ExecutionException {
		OAuth20Service oauthService = new ServiceBuilder()
				.apiKey(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.build(LoginNaverApi.instance());
		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		oauthService.signRequest(oauthToken, request);
		Response response = request.send();
		return response.getBody();
	}
	
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
