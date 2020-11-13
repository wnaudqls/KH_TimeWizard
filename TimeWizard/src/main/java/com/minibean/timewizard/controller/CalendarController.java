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
import org.springframework.web.bind.annotation.RequestMapping;

import com.minibean.timewizard.model.biz.CalendarBiz;
import com.minibean.timewizard.model.dto.CalendarDto;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.utils.calendar.CalendarUtils;

@Controller
public class CalendarController {

	private Logger logger = LoggerFactory.getLogger(CalendarController.class);
	
	@Autowired
	CalendarBiz calBiz;
	@RequestMapping("/calendar")
	public String calendarForm(HttpSession session, HttpServletRequest request) {
		
		UserInfoDto login = (UserInfoDto)session.getAttribute("login");
		Calendar cal = Calendar.getInstance();

		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		String yyyyMM = year + CalendarUtils.isTwo(month+"");
		System.out.println("yyyyMM: "+yyyyMM);
		CalendarDto dto = new CalendarDto();
		int user_no = login.getUser_no();
		dto.setCal_mdate(yyyyMM);
		String ymd = dto.getCal_mdate();
		List<CalendarDto>clist = calBiz.getViewList(user_no, ymd);
		logger.info("년도:{}, 월:{}",year,month);
		request.setAttribute("paramYear", year);
		
		session.setAttribute("clist", clist);
		return "calendar"; 
	}
	
}
