package com.minibean.timewizard.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.minibean.timewizard.model.biz.ChatBiz;
import com.minibean.timewizard.model.biz.ChatBizImpl;
import com.minibean.timewizard.model.dto.ChatDto;






@Controller
public class GroupController {
	
	@Autowired
	private final ChatBiz biz = new ChatBizImpl();
	
	
	@GetMapping("/grouplist")
	public String list(Model model) {
		/* model.addAttribute("rooms", biz.selectList()); */
		 model.addAttribute("list", biz.findAllRoom()); 
		return "grouplist";
	}


	
	@GetMapping("/joinroom/{name}")
	public String room(@PathVariable("name") String name, Model model) {
		 ChatDto room = biz.findRoomById(name);  
		/* 아직 작업중
		 * 
		 * ChatDto room = biz.selectOne(name); 
		 * 
		 * */
		model.addAttribute("dto", room);
	
		return "grouproom";
	}
	@GetMapping("/newroom")
	public String make(Model model) {
		return "newRoom";
	}

	@PostMapping(value="/createres", params={"name"})
	public String makeRoom(@RequestParam("name") String name, ChatDto dto) {
	/*	
		아직 작업중
	 	int res = biz.insert(dto);
		if(res > 0) {
			biz.createChatRoom(name);
			return "redirect:/grouplist";
		}
		else {
			return "redirect:/newroom";
		}
		
		*/
		
		biz.createChatRoom(name);
		return "redirect:/newroom";
	}
}
