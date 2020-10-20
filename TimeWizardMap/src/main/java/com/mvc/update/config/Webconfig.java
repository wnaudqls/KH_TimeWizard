package com.mvc.update.config;

import javax.servlet.FilterRegistration;

//web.xml을 .java(클래스)로 바꾸는 작업 할 것

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;

public class Webconfig implements WebApplicationInitializer {

	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		// ApplicationConfig
		AnnotationConfigWebApplicationContext applicationConfig =
				new AnnotationConfigWebApplicationContext();
		applicationConfig.register(ApplicationConfig.class);
		
		// Listener
		servletContext.addListener(new ContextLoaderListener(applicationConfig));
		
		// ServletConfig
		AnnotationConfigWebApplicationContext servletConfig = new AnnotationConfigWebApplicationContext();
		servletConfig.register(ServletConfig.class);
		
		ServletRegistration.Dynamic dispatcherServlet =
				servletContext.addServlet("dispatcherServlet", new DispatcherServlet(servletConfig));
		dispatcherServlet.setLoadOnStartup(1);
		dispatcherServlet.addMapping("*.do");
		
		// Filter
		FilterRegistration.Dynamic filterRegistration =
				servletContext.addFilter("encodingFilter", new CharacterEncodingFilter("UTF-8", true));
		filterRegistration.addMappingForUrlPatterns(null, true, "/*");

	}

}
