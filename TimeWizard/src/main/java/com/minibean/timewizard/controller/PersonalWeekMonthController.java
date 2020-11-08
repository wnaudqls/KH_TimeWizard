package com.minibean.timewizard.controller;

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

@RestController
public class PersonalWeekMonthController {
	
	@Autowired
	private UserTodoBiz userTodoBiz;
	
	private Logger logger = LoggerFactory.getLogger(PersonalDailyController.class);
	
	
	@RequestMapping("/weekly")
	public Map<String, List<UserTodoDto>> selectList(HttpSession session,
			UserInfoDto userinfoDto, Model model) {
		logger.info("[WEEKELY]");
		
		userinfoDto = (UserInfoDto)session.getAttribute("login");
		
		List<UserTodoDto> list = userTodoBiz.selectList(userinfoDto.getUser_no());
		
		
		logger.info("user_no : "+userinfoDto.getUser_no());
		logger.info("list : "+list);
		
		Map<String, List<UserTodoDto>> map = new HashMap<String, List<UserTodoDto>>();
		map.put("list",list);
		
		logger.info("map : "+map);
		return map;
	}
	
	

}
