package com.mvc.update.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
@PropertySource("classpath:sqls/db.properties")
public class ApplicationConfig {

	// 위의 db.properties에서 가져온 값들을 아래 private 변수들에 넣어줄 것
	
	@Value("${oracle.driver}")
	private String driver;
	
	@Value("${oracle.url}")
	private String url;
	
	@Value("${oracle.username}")
	private String username;
	
	@Value("${oracle.password}")
	private String password;
	
	
	// DataSource는 import 할 때 javax.sql로 가져와야 함
	public DataSource dataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(driver);
		dataSource.setUrl(url);
		dataSource.setUsername(username);
		dataSource.setPassword(password);
		
		return dataSource;
	}
	
	@Bean
	public JdbcTemplate jdbcTemplate() {
		JdbcTemplate jdbcTemplate = new JdbcTemplate();
		jdbcTemplate.setDataSource(dataSource());
		return jdbcTemplate;
	}
}
