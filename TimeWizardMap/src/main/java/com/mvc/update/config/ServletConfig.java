package com.mvc.update.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

// Servlet-context.xml들이랑 연결해주는 annotation (xml파일을 java파일로 바꿔줌)

@Configuration
@EnableWebMvc	// <annotation-driven />
@ComponentScan("com.mvc.update")	// <context:component-scan base-package="com.mvc.update" />
public class ServletConfig implements WebMvcConfigurer {
	
	// <!-- Handles HTTP GET requests for /resources/** by efficiently serving up static resources in the ${webappRoot}/resources directory -->
	// <resources mapping="/resources/**" location="/resources/" />
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}

	// method 이름은 크게 중요하지 않음
	// <beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
	@Bean
	public InternalResourceViewResolver getViewResolver() {
		String prefix = "/WEB-INF/views/";
		String suffix = ".jsp";
		
		return new InternalResourceViewResolver(prefix, suffix);
	}
	
	
	
	
	
}
