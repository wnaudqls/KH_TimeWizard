package com.minibean.timewizard.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogFilter implements Filter {

	Logger logger = LoggerFactory.getLogger(LogFilter.class);
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;

		String remoteAddr = req.getRemoteAddr();
		String uri = req.getRequestURI();
		String url = req.getRequestURL().toString();
		String queryString = req.getQueryString();

		String referer = req.getHeader("referer");
		String userAgent = req.getHeader("User-Agent");

		StringBuffer sb = new StringBuffer();
		sb.append("* " + remoteAddr + "\n");
		sb.append("* " + uri + "\n");
		sb.append("* " + url + "\n");
		sb.append("* " + queryString + "\n");
		sb.append("* " + referer + "\n");
		sb.append("* " + userAgent + "\n");

		logger.info("* LOG Filter");
		logger.info(sb + "");
		logger.info("*****");

		chain.doFilter(request, response);

	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}
