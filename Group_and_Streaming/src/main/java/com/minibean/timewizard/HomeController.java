package com.minibean.timewizard;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Handles requests for the application home page.
 */

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping("/")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/grouplist")
	public String grouplist() {
		return "group_list";
	}
	
	@RequestMapping("/streaming")
	public String streaming() {
		return "group_room";
	}
	@RequestMapping("/list")
	public String list() {
		return "list";
	}
	
	
	
}
