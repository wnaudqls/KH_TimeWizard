package com.minibean.timewizard.controller;

import java.util.List;

import javax.servlet.RequestDispatcher;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class AdminController {
	
	private Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private UserInfoBiz userinfoBiz;
	
	@RequestMapping(value="/adminpage")
	public String AdminPage(Model model, UserInfoDto user_no) {
		logger.info("[adminpage]");
		
		model.addAttribute("list", userinfoBiz.selectList());
		// model.addAttribute("user_no", userinfoBiz.selectOne(user_no));
		
		return "adminpage";
	}
	
	// 회원 등급 변경 버튼 누르면 등급변경 페이지로 이동
	@RequestMapping(value="/adminrole")
	public String AdminRole(Model model, UserInfoDto dto, UserInfoDto user_no, UserInfoDto user_id, UserInfoDto user_role) {
		logger.info("[admin role change]");
		
		model.addAttribute("dto", userinfoBiz.selectOne(dto));
		// model.addAttribute("list", userinfoBiz.selectList());
		
		/* String member_id = request.getParameter("member_id");
			String member_role = request.getParameter("member_role");
			System.out.println(member_id);
			System.out.println(member_role);
			
			//dto에 세팅
			dto = new adDto(member_id, member_role);
			
			//dto 대신 adDao에서 맵에 담아도 됨
			int res = dao.update(dto);
			System.out.println(res);
			
			if (res > 0){
				System.out.println("등급 변경 성공!");
				RequestDispatcher dispatch = request.getRequestDispatcher("./adController?command=allMember");
				dispatch.forward(request, response);
			} else {
				System.out.println("등급 변경 실패");
				RequestDispatcher dispatch = request.getRequestDispatcher("admin/adrolemanager.jsp");
				dispatch.forward(request, response);
			}
			
			*/
		
		return "adminrole";
	}
	
	/* 강제 탈퇴 버튼 누르면 강제탈퇴 페이지로 이동
	@RequestMapping(value="/admindelete")
	public String AdminDelete(Model model, UserInfoDto dto, UserInfoDto user_no, UserInfoDto user_id, UserInfoDto user_role) {
		logger.info("[admin member delete]");
		
		 UserInfoDto res = (UserInfoDto) );
		boolean check = false;
		if(res != 0) {
			session.invalidate();
			loginResponse("탈퇴 되었습니다.", "main/main.jsp", response);
		} else {
			loginResponse("탈퇴 실패하였습니다.", "MyinfoController?command=myinfo&member_id="+member_id, response);
		}
		
		return "adminpage";
	} */
	
}
	

