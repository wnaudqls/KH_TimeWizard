package com.minibean.timewizard.utils;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import com.github.scribejava.core.model.OAuth2AccessToken;

public class LoginKakaoVO {

	
private String SESSION_STATE;
	
	public String getAuthorizationUrl(HttpSession session) {
		return "";
	}
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) {
		return null;
	}
	public String getUserProfile(OAuth2AccessToken oauthToken) {
		return "";
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
