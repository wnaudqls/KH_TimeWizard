package com.mvc.upgrade.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.upgrade.model.biz.BoardBiz;
import com.mvc.upgrade.model.dto.BoardDto;

@Controller
public class BoardController {
	
	// value= , method= 생략가능
	
	@Autowired
	private BoardBiz boardBiz;
	
	private Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping("/list.do")
	public String selectList(Model model) {
		logger.info("[SELECT LIST]");
		
		model.addAttribute("list", boardBiz.selectList());
		
		return "mvclist";
	}
	
	@RequestMapping("/detail.do")
	public String detail(Model model, @RequestParam("myno") int myno) {
		logger.info("[DETAIL]");
		
		BoardDto dto = boardBiz.selectOne(myno);
		model.addAttribute("dto", dto);
		
		return "mvcdetail";
	}
	
	@RequestMapping("/insert.do")
	public String insertForm() {
		logger.info("[INSERT FORM]");
		
		return "mvcinsert";
	}
	
	@RequestMapping("/insertres.do")
	public String insertRes(BoardDto dto, Model model) {
		logger.info("[INSERT RES]");
		
		int res = boardBiz.insert(dto);
		if (res > 0) {
			model.addAttribute("list", boardBiz.selectList());
			return "redirect:list.do";
		}
		
		return "redirect:list.do";
	}
	
	@RequestMapping("/update.do")
	public String updateForm(Model model, int myno) {
		logger.info("[UPDATE FORM]");
		
		BoardDto dto = boardBiz.selectOne(myno);
		model.addAttribute("dto", dto);
		
		return "mvcupdate";
	}
	
	@RequestMapping("/updateres.do")
	public String updateRes(BoardDto dto) {
		logger.info("[UPDATE RES]");
		
		int res = boardBiz.update(dto);
		if (res > 0) {
			return "redirect:detail.do?myno="+dto.getMyno();
		} else {
			return "redirect:update.do?myno="+dto.getMyno();
		}
	}
	
	@RequestMapping("/delete.do")
	public String delete(int myno) {
		logger.info("[DELETE]");
		
		int res = boardBiz.delete(myno);
		if (res > 0) {
			return "redirect:list.do";
		} else {
			return "redirect:detail.do?myno="+myno;
		}
	}
	
	@RequestMapping("/test.do")
	public String transactionTest() {
		logger.info("[test.do]");
		
		boardBiz.transactionTest();
		
		return "redirect:list.do";
	}
	
	@RequestMapping("/finalnotice.do")
	public String finalNotice() {
		logger.info("[finalnotice.do]");
		
		return "finalnotice";
	}
	
	@RequestMapping("/finalnoticedetail.do")
	public String finalnoticeDetail() {
		logger.info("[finalnoticedetail.do]");
		
		return "finalnoticedetail";
	}
	
	@RequestMapping("/finaltimer.do")
	public String finalTimer() {
		logger.info("[finaltimer.do]");
		
		return "finaltimer";
	}

	@RequestMapping("/finalstopwatch.do")
	public String finalStopwatch() {
		logger.info("[finalstopwatch.do]");
		
		return "finalstopwatch";
	}
	
	@RequestMapping("/finalactionpage.do")
	public String finalActionpage() {
		logger.info("[finalactionpage.do]");
		
		return "finalactionpage";
	}
}




































