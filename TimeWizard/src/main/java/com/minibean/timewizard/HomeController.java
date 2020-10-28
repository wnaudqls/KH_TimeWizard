package com.minibean.timewizard;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;


import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		return "home";
	}
	
	
	@RequestMapping(value="/")
	public String index() {
		logger.info(">> [CONTROLLER-HOME] go to index page");
		return "index";
	}
	
    @RequestMapping(value="/logout")
	public String invalidate(HttpSession session) {
		logger.info(">> [CONTROLLER-HOME] user logout");
		session.invalidate();
		return "redirect:login/loginform";
	}
	
    /* test 용입니다 */
	@RequestMapping(value="/success")
	public String successPage() {
		return "success";
	}
	
	@RequestMapping(value="/finalnotice")
	public String finalnotice() {
		return "notice";
	}

	@RequestMapping(value="/finalnoticedetail")
	public String finalnoticedetail() {
		return "notice_detail";
	}
	
	@RequestMapping(value="/finalstopwatch")
	public String finalstopwatch() {
		return "finalstopwatch";
	}
	
	@RequestMapping(value="/finaltimer")
	public String finaltimer() {
		return "finaltimer";
	}
	
	@RequestMapping(value="/daily")
	public String personalDaily() {
		return "personal_daily";
	}

}
