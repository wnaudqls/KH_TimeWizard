package com.minibean.timewizard.controller;

import java.lang.reflect.Array;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.minibean.timewizard.model.biz.UserTodoBiz;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.model.dto.UserTodoDto;
import com.minibean.timewizard.model.dto.WeeklyDto;

@RestController
public class PersonalWeekMonthController {
	
	@Autowired
	private UserTodoBiz userTodoBiz;
	
	private Logger logger = LoggerFactory.getLogger(PersonalWeekMonthController.class);
	
	
	@RequestMapping("/weekly")
	public Map<String, WeeklyDto> selectList(HttpSession session,
			UserInfoDto userinfoDto, Model model) {
		logger.info("[WEEKELY]");
		
		userinfoDto = (UserInfoDto)session.getAttribute("login");
		
		WeeklyDto dto = userTodoBiz.chart(userinfoDto.getUser_no());
		
		Map<String, WeeklyDto> map = new HashMap<String, WeeklyDto>();
		map.put("dto", dto);
		
		String[] arr;
		logger.info("user_no : "+userinfoDto.getUser_no());
		//logger.info("map : "+map.get(dto));
		//arr = dto.getThe_date().split(",");
		//logger.info("the_date : "+arr);
		
		return map;
	}
	
	
	
	
	

}
