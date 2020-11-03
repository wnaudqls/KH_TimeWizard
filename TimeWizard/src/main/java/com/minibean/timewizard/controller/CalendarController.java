package com.minibean.timewizard.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CalendarController {

	private Logger logger = LoggerFactory.getLogger(CalendarController.class);
	
	@RequestMapping("/calendar")
	public String calendarForm() {
		return "calendar"; 
	}
	
}
