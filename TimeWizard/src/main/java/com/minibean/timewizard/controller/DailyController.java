package com.minibean.timewizard.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.HandlerMapping;

import com.minibean.timewizard.model.biz.UserTodoBiz;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.model.dto.UserTodoDto;

@Controller
@RequestMapping(value="/daily")
public class DailyController {
	
	@Autowired
	private UserTodoBiz userTodoBiz;
	private Logger logger = LoggerFactory.getLogger(DailyController.class);
	 /* date : yyyyMMdd 식으로 호출은 어려울까? */
	@RequestMapping(value="/list/{yyyyMMdd}")
	@ResponseBody
	public List<UserTodoDto> dailyList(HttpSession session, HttpServletRequest request, @PathVariable String yyyyMMdd) {
		logger.info(">> [CONTROLLER-DAILY] todo list");
		UserInfoDto login = (UserInfoDto) session.getAttribute("login");
		int user_no = login.getUser_no();
		
		String path = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		String date = path.split("/")[3];
		logger.info("PATH CHECK\n* path : " + path + "\n* yyyyMMdd : " + date);
		/* parameter setting */
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		hashmap.put("user_no", user_no);
		hashmap.put("todo_date", date);
		List<UserTodoDto> list = userTodoBiz.selectList(hashmap);
		
		if (list == null || list.size() == 0) {
			/* list가 null일 때 */
			int res = userTodoBiz.insertExample(user_no);
			logger.info(">> example insert... - " + (res == 1?"성공":"실패"));
			return dailyList(session, request, date);
		} else {
			/* list가 null이 아닐 때 */
			return list;
		}
		
		
	}
	
	@RequestMapping(value="/detail/{todo_no}")
	@ResponseBody
	public UserTodoDto dailyDetail(@PathVariable("todo_no") int todo_no, HttpSession session) {
		logger.info(">> [CONTROLLER-DAILY] detail - " + todo_no);
		UserInfoDto login = (UserInfoDto) session.getAttribute("login");
		UserTodoDto dto = userTodoBiz.selectOne(todo_no);
		return dto;
	}
	
	@RequestMapping(value="/insert")
	@ResponseBody
	public void dailyInsert(@RequestBody UserTodoDto dto, HttpSession session) {
		UserInfoDto login = (UserInfoDto) session.getAttribute("login");
		dto.setUser_no(login.getUser_no());
		logger.info(">> [CONTROLLER-DAILY] insert content"
					+ "\n\t* user_no : " + dto.getUser_no()
					+ "\n\t* todo_title : " + dto.getTodo_title() 
					+ "\n\t* todo_content : " + dto.getTodo_content());
		int res = userTodoBiz.insert(dto);
		logger.info(">> [CONTROLLER-DAILY] success?: " + ((res == 1)?"yes":"no"));
	}
	
	@RequestMapping(value="/update")
	@ResponseBody
	public void dailyUpdate(@RequestBody UserTodoDto dto, HttpSession session) {
		UserInfoDto login = (UserInfoDto) session.getAttribute("login");
		dto.setUser_no(login.getUser_no());
		logger.info(">> [CONTROLLER-DAILY] update content"
				+ "\n\t* user_no : " + dto.getUser_no()
				+ "\n\t* todo_title : " + dto.getTodo_title());
		int res = userTodoBiz.update(dto);
		logger.info(">> [CONTROLLER-DAILY] success?: " + ((res == 1)?"yes":"no"));
	}
	
	@RequestMapping(value="/delete")
	@ResponseBody
	public void dailyDelete(@RequestBody int todo_no) {
		// 유저 정보 체크는 언제...? 유저 정보 같을 때만 삭제 란이 활성화되게 하면 되지만...
		logger.info(">> [CONTROLLER-DAILY] delete content"
				+ "\n\t* todo_no : " + todo_no);
		int res = userTodoBiz.delete(todo_no);
		logger.info(">> [CONTROLLER-DAILY] success?: " + ((res == 1)?"yes":"no"));
	}

}
