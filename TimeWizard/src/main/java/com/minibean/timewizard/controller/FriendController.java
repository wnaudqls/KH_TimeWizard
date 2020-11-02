package com.minibean.timewizard.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.minibean.timewizard.model.biz.FriendBiz;
import com.minibean.timewizard.model.dto.FriendDto;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class FriendController {
	
	@Autowired
	private FriendBiz friendBiz;
	
	@Autowired
	SimpMessagingTemplate template;
	
	private Logger logger = LoggerFactory.getLogger(FriendController.class);
	
	@RequestMapping("/friend")
	public String selectList(HttpSession session) {
		
		UserInfoDto dto = (UserInfoDto)session.getAttribute("login");
		
		//나와 친구인 유저들 리스트
		List<FriendDto> list = friendBiz.selectListF(dto.getUser_no());
		session.setAttribute("flist", list);
		
		
		//나와 친구가 아닌 유저들 리스트
		List<FriendDto> list2 = friendBiz.selectListN(dto.getUser_no());
		session.setAttribute("nlist",list2);
		
		
		return "redirect:/main";
	}
	
	//로그인 했을때, 클라이언트로 부터 값을 받을 경로
	@MessageMapping("/login/join")
    public void join() {
		logger.info("님 등장");
	
			
			//전송해줄 경로에 값을 넣어서 클라이언트에게 전송
			//friend_no에게 전송됨
			template.convertAndSend("/subscribe/login/res/", "44555");
		
	}
	
	//신청버튼 클릭시, 클라이언트로 부터 값을 받을 경로
	@MessageMapping("/alert/friend")
    public void message(FriendDto dto) {
		logger.info("신청한 사람: "+dto.getUser_no()+"신청받은 사람: "+dto.getFriend_no());
		//클라이언트에게 받은 값을 UserInfoDto 형식을 사용해 출력
		
		int res = friendBiz.SendInsert(dto);
		logger.info("결과: {}",res);
		if(res >= -1) {
			template.convertAndSend("/subscribe/alert/good/"+dto.getFriend_no(),dto.getUser_no());
			//전송해줄 경로 + 친구신청을 받게될 이름 주소로 해당 값을 넣은뒤 전송
			
		}
    }
}
