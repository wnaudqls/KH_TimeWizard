package com.mvc.upgrade.common.interceptor;

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
		
		// 이 조건일때만 디스패쳐서블릿에서 컨트롤러로 넘어간다
		// spring 3.2 이상부터는 servlet-context.xml에서 <exculude-mapping-path>를 통해 설정할 수 있다.
		// 로그인 값이 null이 아니라면, 즉 로그인이 되어있다면 return true
		// 로그인이 null이라면, 즉 로그인이 되어있지 않다면 return false
		if (
				request.getRequestURI().contains("/loginform.do") ||
				request.getRequestURI().contains("/ajaxlogin.do") ||
				request.getSession().getAttribute("login") != null ||
				request.getRequestURI().contains("/test.do") ||
				request.getRequestURI().contains("/registform.do") ||
				request.getRequestURI().contains("/registres.do")
			) {
			return true;
		} 
		
		if (request.getSession().getAttribute("login") == null) {
			response.sendRedirect("loginform.do");
			return false;
		}
		
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("[LoginInterceptor] : postHandle");
		
		// 내가 요청했을 때 응답되는 페이지
		// logger.info(modelAndView.getViewName());
		if (modelAndView != null) {
			logger.info(modelAndView.getViewName());
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		logger.info("[LoginInterceptor] : afterCompletion");
	}

}



















