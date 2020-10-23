package com.minibean.timewizard.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {
	Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("LOGININTERCEPTOR::prehandle=============================");
		logger.info("Class \t : " + handler.getClass());
		logger.info("Request URI \t : " + request.getRequestURI());
		logger.info("Servlet URI \t : " + request.getServletPath());
		
		Enumeration<String> paramNames = request.getParameterNames();
		
		while (paramNames.hasMoreElements()) {
			String key = (String) paramNames.nextElement();  
			String value = request.getParameter(key);
			logger.info("# Request Parameter : " + key + "=" + value);
		}
		logger.info("========================================================");
		
		//session에 값이 없으면,
		if(request.getSession().getAttribute("login")==null) {
			response.sendRedirect("login/loginform");
			return false;
		}
		
		return false;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {
		logger.info("LOGININTERCEPTOR::posthandle=============================");
		
		if(modelAndView != null) {
			logger.info(modelAndView.getViewName());
		}
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
		logger.info("LOGININTERCEPTOR::aftercompletion=========================");
	}
}
