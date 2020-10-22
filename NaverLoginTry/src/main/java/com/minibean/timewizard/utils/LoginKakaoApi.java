package com.minibean.timewizard.utils;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class LoginKakaoApi extends DefaultApi20 {
	
	protected LoginKakaoApi() {}
	
	private static class InstanceHolder {
		private static final LoginKakaoApi INSTANCE = new LoginKakaoApi();
	}
	
	public static LoginKakaoApi instance() {
		return InstanceHolder.INSTANCE;
	}

	@Override
	public String getAccessTokenEndpoint() {
		return "https://kauth.kakao.com/oauth/token";
	}

	@Override
	protected String getAuthorizationBaseUrl() {
		return "https://kauth.kakao.com/oauth/authorize?response_type=code";
	}

}
