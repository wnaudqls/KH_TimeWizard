package com.minibean.timewizard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.minibean.timewizard.model.biz.UserTodoBiz;

@Controller
public class DailyController {
	
	@Autowired
	private UserTodoBiz userTodoBiz;
	
	@RequestMapping("dailylist")
	public String dailList(Model model) {
		
		model.addAttribute("list", userTodoBiz.selectList());
		return "dailylist";
	}

}
