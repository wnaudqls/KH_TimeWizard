package com.minibean.timewizard.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.minibean.timewizard.biz.ChatBiz;
import com.minibean.timewizard.biz.ChatBizImpl;
import com.minibean.timewizard.dao.ChatDao;
import com.minibean.timewizard.dao.ChatDaoImpl;

/**
 * Handles requests for the application home page.
 */

@Controller
public class GroupController {
	
	ChatDao dao = new ChatDaoImpl();
	
	@Autowired
	ChatBiz biz = new ChatBizImpl();

	private static final Logger logger = LoggerFactory.getLogger(GroupController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping(value="/")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/grouplist")
	public String grouplist(Model model) {
		model.addAttribute("list", biz.selectList());
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
	@RequestMapping("/new")
	public String room() {
		return "new";
	}
	
	@RequestMapping("/create")
	public String create(Model model, String user_id) {
		return "redirect:/list";
	}
	
	
}
