package com.minibean.timewizard.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

	Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("[LoginInterceptor] : preHandle");
		
		// 해당 조건일때만 디스패쳐 서플릿 거쳐 컨트롤러로 넘어 갈 수 있음
		// spring 3.2 이상부터는 selvlet-context.xml에서 <exclude-mapping-path>를 통해서 설정 할 수 있다.
		if(request.getRequestURI().contains("/usersignup.do")) 
		{
			return true;
		}
		
		if (request.getSession().getAttribute("login")==null) {
			response.sendRedirect("loginform.do");
			
			return false;
			
		}
		
		return false; //<= false true 비교해보자
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("[LoginInterceptor] : postHandle");
		//logger.info(modelAndView.getViewName());
		
		if(modelAndView !=null) {
			logger.info(modelAndView.getViewName());
		}
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		logger.info("[LoginInterceptor] : afterCompletion");
		
	}

	
}
