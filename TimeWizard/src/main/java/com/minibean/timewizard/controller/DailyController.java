package com.minibean.timewizard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.minibean.timewizard.model.biz.DailyBiz;

@Controller
public class DailyController {
	
	@Autowired
	private DailyBiz dailyBiz;
	
	@RequestMapping("dailylist")
	public String dailList(Model model) {
		
		
		model.addAttribute("list", dailyBiz.selectList());
		return "dailylist";
	}

}
