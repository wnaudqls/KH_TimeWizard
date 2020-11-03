package com.minibean.timewizard.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.HandlerMapping;

import com.minibean.timewizard.model.biz.UserTodoBiz;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.model.dto.UserTodoDto;

@RestController
@RequestMapping(value="/daily")
public class PersonalDailyController {
	
	@Autowired
	private UserTodoBiz userTodoBiz;
	private Logger logger = LoggerFactory.getLogger(PersonalDailyController.class);
	
	@PostMapping(value="/list/{yyyyMMdd}")
	public List<UserTodoDto> dailyList(HttpSession session, HttpServletRequest request, @PathVariable String yyyyMMdd) {
		logger.info(">> [CONTROLLER-DAILY] todo list");
		UserInfoDto login = (UserInfoDto) session.getAttribute("login");
		int user_no = login.getUser_no();
		
		String path = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		String date = path.split("/")[3]; // personal 경로 수정시 수정해야 함!
		logger.info("PATH CHECK\n* path : " + path + "\n* yyyyMMdd : " + date);
		/* parameter setting */
		int newOrNot = userTodoBiz.countList(user_no);
		
		/* userlogin 정보와 접속 정보가 동일할 떄만 */
		if (newOrNot == 0) {
			/* list가 null일 때 */
			int res = userTodoBiz.insertExample(user_no);
			logger.info(">> example insert... - " + (res == 1?"성공":"실패"));
			return dailyList(session, request, date);
		} else {
			/* 전체 list가 null이 아닐 때 */
			HashMap<String, Object> hashmap = new HashMap<String, Object>();
			hashmap.put("user_no", user_no);
			hashmap.put("todo_date", date);
			List<UserTodoDto> list = userTodoBiz.selectList(hashmap);
			return list;
		}
		
	}
	
	@PostMapping(value="/detail/{todo_no}")
	public UserTodoDto dailyDetail(@PathVariable("todo_no") int todo_no) {
		logger.info(">> [CONTROLLER-DAILY] detail - " + todo_no);
		UserTodoDto dto = userTodoBiz.selectOne(todo_no);
		logger.info(">> [CONTROLLER-DAILY] detail content"
				+ "\n\t* user_no : " + dto.getUser_no()
				+ "\n\t* todo_title : " + dto.getTodo_title() 
				+ "\n\t* todo_content : " + dto.getTodo_content()
				+ "\n\t* todo_date : " + dto.getTodo_date());
		return dto;
	}
	
	@PostMapping(value="/insert")
	public void dailyInsert(@RequestBody UserTodoDto dto, HttpSession session) {
		logger.info("\n\t* todo_starttime : " + dto.getTodo_starttime());
		UserInfoDto login = (UserInfoDto) session.getAttribute("login");
		/* userlogin 정보와 link 정보가 동일할 때만 !!! */
		dto.setUser_no(login.getUser_no());
		logger.info(">> [CONTROLLER-DAILY] insert content"
					+ "\n\t* user_no : " + dto.getUser_no()
					+ "\n\t* todo_title : " + dto.getTodo_title() 
					+ "\n\t* todo_content : " + dto.getTodo_content()
					+ "\n\t* todo_date : " + dto.getTodo_date()
					+"\n\t* todo_starttime : " + dto.getTodo_starttime());
		
		int res = userTodoBiz.insert(dto);
		logger.info(">> [CONTROLLER-DAILY] success?: " + ((res == 1)?"yes":"no"));
	}
	
	@PostMapping(value="/update")
	public void dailyUpdate(@RequestBody UserTodoDto dto, HttpSession session) {
		UserInfoDto login = (UserInfoDto) session.getAttribute("login");
		/* userlogin 정보와 link 정보가 동일할 때만 !!! */
		dto.setUser_no(login.getUser_no());
		logger.info(">> [CONTROLLER-DAILY] update content"
				+ "\n\t* user_no : " + dto.getUser_no()
				+ "\n\t* todo_title : " + dto.getTodo_title() 
				+ "\n\t* todo_content : " + dto.getTodo_content()
				+ "\n\t* todo_date : " + dto.getTodo_date());
		int res = userTodoBiz.update(dto);
		logger.info(">> [CONTROLLER-DAILY] success?: " + ((res == 1)?"yes":"no"));
	}
	
	@PostMapping(value="/delete/{todo_no}")
	public void dailyDelete(@PathVariable("todo_no") int todo_no) {
		logger.info(">> [CONTROLLER-DAILY] delete content"
				+ "\n\t* todo_no : " + todo_no);
		/* userlogin 정보와 link 정보가 동일할 때만 !!! */
		int res = userTodoBiz.delete(todo_no);
		logger.info(">> [CONTROLLER-DAILY] success?: " + ((res == 1)?"yes":"no"));
	}

}
