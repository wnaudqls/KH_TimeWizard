package com.minibean.timewizard.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.minibean.timewizard.model.biz.FriendBiz;
import com.minibean.timewizard.model.dto.FriendDto;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class FriendController {
	
	@Autowired
	private FriendBiz friendBiz;
	
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
}
