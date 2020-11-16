package com.minibean.timewizard.controller;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.minibean.timewizard.model.biz.CalendarBiz;
import com.minibean.timewizard.model.dto.CalendarDto;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.utils.calendar.CalendarUtils;

@RestController
@RequestMapping("/calendar")
public class CalendarController {

	private Logger logger = LoggerFactory.getLogger(CalendarController.class);

	@Autowired
	CalendarBiz calBiz;


	@RequestMapping("/calendarlist/{year}/{month}/{date}")
	public String calednarDetail(Model model,
								@PathVariable String year,
								@PathVariable String month,
								@PathVariable String date,
								HttpSession session) {
		
		logger.info(" ---  < Calendar Detail > --- ");
		UserInfoDto dto = (UserInfoDto)session.getAttribute("login");
		int user_no = dto.getUser_no();
		String yyyyMMdd = year+ CalendarUtils.isTwo(month)+ CalendarUtils.isTwo(date);
		
		List<CalendarDto>list = calBiz.getCalList(user_no, yyyyMMdd);
		model.addAttribute("list",list);
		
		return "calendarlist";
	}
	
	

	@RequestMapping("/calinsert/{year}/{month}/{date}/{LastDay}")
	public String calInsert(@PathVariable String year,
					@PathVariable String month,
					@PathVariable String date,
					@PathVariable String LastDay,
					Model model) {
		
		logger.info(" *** year" +year);
		logger.info(" *** month"+month);
		logger.info(" *** date"+date);
		logger.info(" *** LastDay"+LastDay);
		
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		model.addAttribute("date",date);
		model.addAttribute("LastDay",LastDay);
		
		
		return "calendarinsert";
		
	}
	
	@RequestMapping("/timewizard/calendar/caldetail")
	public String calendarForm(HttpSession session, Model model,@PathVariable int cal_no) {
		
		UserInfoDto dto = (UserInfoDto) session.getAttribute("login");
		CalendarDto calDto = new CalendarDto();
		logger.info(" **********캘린더 리스트 -> 디테일로 넘어오는 user_no : "+dto.getUser_no());
		logger.info(" < Calendar Detail > ");
		
		calDto = calBiz.selectOne(cal_no);
		model.addAttribute("calDto",calDto);

		return "calendar_detail";

	}


}
