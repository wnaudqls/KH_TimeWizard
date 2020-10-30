package com.minibean.timewizard.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.minibean.timewizard.message.ChatMessage;
import com.minibean.timewizard.model.biz.ChatBiz;
import com.minibean.timewizard.model.biz.ChatBizImpl;
import com.minibean.timewizard.model.dto.ChatDto;






@Controller
public class GroupController {
	@Autowired
	SimpMessagingTemplate template;

	
	@Autowired
	private final ChatBiz biz = new ChatBizImpl();

	
	
	
	
	@GetMapping("/")
	public String index(Model model) {
		return "index";
	}
	
	
	@GetMapping("/grouplist")
	public String list(Model model) {
		 model.addAttribute("list", biz.selectList()); 
		return "grouplist";
	}


	
	@GetMapping("/joinroom/{name}")
	public String room(@PathVariable("name") String name, Model model) {
		 
		  
		ChatDto room = biz.selectOne(name); 
		  
		  
		model.addAttribute("dto", room);
	
		return "grouproom";
	}
	@GetMapping("/newroom")
	public String make(Model model) {
		return "newRoom";
	}

	@PostMapping(value="/createres", params={"name"})
	public String makeRoom(@RequestParam("name") String name, ChatDto dto) {
		
	 	int res = biz.insert(dto);
		if(res > 0) {
			
			return "redirect:/grouplist";
		}
		else {
			return "redirect:/newroom";
		}
		
	}
	
	@MessageMapping("/chat/join")
    public void join(ChatMessage message) {
		System.out.println(message.getWriter()+"님 등장");
		
		message.setMessage(message.getWriter() + "님이 입장하셨습니다.");
        template.convertAndSend("/subscribe/chat/room/", message);
    }

	@MessageMapping("/chat/message")
    public void message(ChatMessage message) {
		System.out.println(message.getRoomid()+"번 채팅방");
        template.convertAndSend("/subscribe/chat/room/"+message.getRoomid(), message);
    }
}
