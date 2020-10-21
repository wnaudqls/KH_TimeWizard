package com.minibean.timewizard;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.minibean.timewizard.biz.ChatBiz;
import com.minibean.timewizard.biz.ChatBizImpl;
import com.minibean.timewizard.dao.ChatDao;
import com.minibean.timewizard.dao.ChatDaoImpl;

/**
 * Handles requests for the application home page.
 */

@Controller
public class ChatController {
	
	ChatDao dao = new ChatDaoImpl();
	
	@Autowired
	ChatBiz biz = new ChatBizImpl();

	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping("/")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/grouplist.do")
	public String grouplist(Model model) {
		model.addAttribute((biz.selectList(),"list");
		return "group_list";
	}
	
	@RequestMapping("/streaming.do")
	public String streaming() {
		ModelAndView modelview = new ModelAndView();
		modelview.setView(new RedirectView("/streaming",true,false));
		return "group_room";
	}
	@RequestMapping("/list.do")
	public String list() {
		return "list";
	}
	@RequestMapping("/new.do")
	public String room() {
		return "new";
	}
	
	@RequestMapping("/create.do")
	public String create(Model model, String user_id) {
		return "redirect:/list.do";
	}
	
	
}
