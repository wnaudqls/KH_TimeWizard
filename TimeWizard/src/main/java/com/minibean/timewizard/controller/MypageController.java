package com.minibean.timewizard.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class MypageController {
	
	private Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	private UserInfoBiz userinfoBiz;
	
	@RequestMapping("/mypage")
	public String Mypage() {
		logger.info("[mypage]");
		return "mypage";
	}
	
	@RequestMapping("/userdeletepage")
	public String UserDeletePage(Model model, @RequestParam int user_no) {
		logger.info("[admin role change]");

		model.addAttribute("dto", userinfoBiz.selectOne(user_no));
		
		return "userdeletepage";
	}
	
	@RequestMapping("/userdeleteres")
	public String UserDelete(UserInfoDto dto, HttpSession session, @RequestParam int user_no) {
		logger.info("[user delete Reusult]");
		
		
		UserInfoDto user = (UserInfoDto) session.getAttribute("login");
		String user_pw = user.getUser_pw();
		String new_pw = dto.getUser_pw();
		
		//비밀번호 불일치로 탈퇴 실패
		if(!(user_pw.equals(new_pw))) {
			return "redirect:mypage";
		} else {
		
			int res = userinfoBiz.delete(user_no);
			
			if(res != 0) {
				System.out.println("탈퇴 성공");
			} else {
				System.out.println("탈퇴 실패");
			}
			
			session.invalidate();
			return "redirect:main";
		}
	}

}
