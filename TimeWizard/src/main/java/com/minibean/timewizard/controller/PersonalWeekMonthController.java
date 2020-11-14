package com.minibean.timewizard.controller;

import java.lang.reflect.Array;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.minibean.timewizard.model.biz.CalendarBiz;
import com.minibean.timewizard.model.biz.UserTodoBiz;
import com.minibean.timewizard.model.dto.CalendarDto;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.model.dto.UserTodoDto;
import com.minibean.timewizard.model.dto.WeeklyDto;
import com.minibean.timewizard.utils.calendar.CalendarUtils;

@RestController
public class PersonalWeekMonthController {
	
	@Autowired
	private UserTodoBiz userTodoBiz;
	
	@Autowired
	private CalendarBiz calBiz;
	
	private Logger logger = LoggerFactory.getLogger(PersonalWeekMonthController.class);
	
	
	@RequestMapping("/weekly/{user_no}")
	public 	WeeklyDto selectList(@PathVariable String user_no ) {
		logger.info("[WEEKELY]");
		
		
		WeeklyDto dto = userTodoBiz.chart(Integer.parseInt(user_no));
	
	
		return dto;
	}
	
	
	@RequestMapping("/cal/{yyyyMMdd}")
	public String calendarListForm(Model model, HttpSession session) {
		logger.info("[cal List Controller]");
		Calendar cal = Calendar.getInstance();
		
		UserInfoDto userinfodto = (UserInfoDto)session.getAttribute("login");
		
		logger.info("userinfodto user_no : "+userinfodto.getUser_no());
		
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int dd = cal.get(Calendar.DATE);
		String yyyyMMdd = year + CalendarUtils.isTwo(month + "")+dd;
		logger.info("yyyyMMdd : " + yyyyMMdd);
		
		List<CalendarDto> list = calBiz.getViewList(userinfodto.getUser_no(), yyyyMMdd);
		
		model.addAttribute("list",list);
		
		return "calendar";
		
	}
	

	
	
	

}
