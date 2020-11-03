package com.minibean.timewizard.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.minibean.timewizard.message.ChatMessage;
import com.minibean.timewizard.model.biz.ChatBiz;
import com.minibean.timewizard.model.biz.ChatBizImpl;
import com.minibean.timewizard.model.dto.ChatDto;






@Controller
public class GroupController {
	@Autowired
	SimpMessagingTemplate template;
	
	Logger log = LoggerFactory.getLogger(GroupController.class);

	
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

	@PostMapping(value="/createres")
	public String makeRoom(ChatDto dto) {
		log.info("비밀번호: ",dto.getChat_password());
	 	int res = biz.insert(dto);
		if(res > 0) {
			log.info("방 생성성공\n방 이름: {}",dto.getChat_title());
			return "redirect:/joinroom/"+dto.getChat_title();
		}
		else {
			log.info("방 생성실패");
			return "redirect:/newroom";
		}
		
	}
	
	@MessageMapping("/chat/join")
    public void join(ChatMessage message) {
		log.info(message.getWriter()+"님 등장");
		int res = biz.clientplus(message.getChat_title());
		log.info("결과: {}",res);
		message.setMessage(message.getWriter() + "님이 입장하셨습니다.");
        template.convertAndSend("/subscribe/chat/join/"+message.getChat_title(), message);
    }

	@MessageMapping("/chat/message")
    public void message(ChatMessage message) {
		log.info("\n"+message.getChat_title()+" 채팅방\n"+message.getWriter()+": "+message.getMessage());
        template.convertAndSend("/subscribe/chat/room/"+message.getChat_title(), message);
    }
	
	@MessageMapping("/chat/disconnect")
    public String disconnect(ChatMessage message) {
		String room = message.getChat_title();
		log.info(message.getWriter()+"님 퇴장");
		int res = biz.clientminus(room);
		log.info("클라이언트 감소 결과: {}",res);
		ChatDto dto = biz.clientnum(room);
		log.info("방 인원 결과: {}",dto.getChat_client());
		int clientnum = dto.getChat_client();
		
		message.setMessage(message.getWriter() + "님이 퇴장하셨습니다.");
        template.convertAndSend("/subscribe/chat/join/"+room, message);
        if(clientnum <= 0) {
			log.info("현재 인원이 0명 입니다. 방 삭제를 하겠습니다.");
			int deleteroom = biz.kaboom(room);
			if(deleteroom > 0) {
				log.info("방 삭제완료.");
				return "redirect:/grouplist";
			}else {
				log.info("방 삭제실패.");
				
			}
		}
        return "";
    }
}
