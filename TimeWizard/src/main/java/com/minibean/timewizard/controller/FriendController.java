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
import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.FriendDto;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class FriendController {
	
	@Autowired
	private FriendBiz friendBiz;
	
	@Autowired
	private UserInfoBiz userBiz;
	
	@Autowired
	SimpMessagingTemplate template;
	
	private Logger logger = LoggerFactory.getLogger(FriendController.class);
	
	@RequestMapping("/friend")
	public String selectList(HttpSession session) {
		
		UserInfoDto dto = (UserInfoDto)session.getAttribute("login");
		
		//나와 친구인 유저들 리스트
		
		List<FriendDto> list = friendBiz.selectListF(dto.getUser_no());
		session.setAttribute("flist", list);
		//return "redirect:/main";
		
		
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
    public void message(FriendDto dto, UserInfoDto udto) {
		udto = userBiz.selectOne(dto.getUser_no());
		logger.info("신청한 사람: {}\n신청받은 사람: {}",udto.getUser_name(), dto.getUser_name());
		//클라이언트에게 받은 값을 UserInfoDto 형식을 사용해 출력
		
		int res = friendBiz.SendInsert(dto);
		logger.info("결과: {}",res);
		if(res >= -1) {
			template.convertAndSend("/subscribe/alert/good/"+dto.getFriend_no(),udto);
			//전송해줄 경로 + 친구신청을 받게될 이름 주소로 해당 값을 넣은뒤 전송
			
		}
    }
	
	//친구 요청 -> "수락"
	//'send'를 'accept'로 바꾸기
	@MessageMapping("/confirm/accept")
	public void accept(FriendDto dto, UserInfoDto udto) {
		udto = userBiz.selectOne(dto.getFriend_no());
		logger.info("accept어어어");
		logger.info("신청한 사람: {}\n신청받은 사람: {}",dto.getUser_name(), udto.getUser_name());
		
		int res = friendBiz.AcceptUpdate(dto);
		logger.info("친구추가 결과: {}",res);
		if(res >= -1) {
			template.convertAndSend("/subscribe/confirm/res/"+dto.getUser_no(),udto);
			logger.info("친구추가 성공");
		}
		
	}
	@MessageMapping("/confirm/fnd")
	public void sendfnd(UserInfoDto dto) {
		logger.info("confirm어어어");
		dto = userBiz.selectOne(dto.getUser_no());
		logger.info("ddddd: "+dto.getUser_no());
		template.convertAndSend("/subscribe/confirm/check/"+dto.getUser_no(),dto);
		
	}
	
	
	//친구 요청 -> "거절"
	@MessageMapping("/confirm/deny")
	public void deny() {
		logger.info("denyㄴ어ㅏㅗㄴ알");
	}
}
