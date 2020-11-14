package com.minibean.timewizard.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/countajax")
public class CalCountAjax {

	
	@RequestMapping("")
	public String countView(@RequestParam int user_no, @RequestParam String yyyMMdd) {
		int user_no = request.getParameter("user_no");
		String yyyyMMdd = request.getParameter("yyyyMMdd");
		System.out.println("mb_id : " + mb_id + "\t yyyyMMdd : " + yyyyMMdd);
		
		
		return "";
		
	}
}
