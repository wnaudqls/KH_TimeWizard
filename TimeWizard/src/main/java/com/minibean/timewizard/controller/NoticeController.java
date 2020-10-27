package com.minibean.timewizard.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.minibean.timewizard.model.biz.NoticeBiz;
import com.minibean.timewizard.model.biz.NoticeBizImpl;
import com.minibean.timewizard.model.dao.NoticeDao;
import com.minibean.timewizard.model.dao.NoticeDaoImpl;
import com.minibean.timewizard.model.dto.NoticeDto;

@Controller
public class NoticeController {
	
	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	NoticeDao dao = new NoticeDaoImpl();
	
	@Autowired
	NoticeBiz biz = new NoticeBizImpl();
	
	@RequestMapping(value="/notice")
	public String noticeList(Model model) {
		logger.info("[LIST]");
		
		model.addAttribute("list", biz.selectList());
		
		return "notice";
	}
	
	@RequestMapping(value="/detail")
	public String detail(Model model, @RequestParam("notice_no") int notice_no) {
		logger.info("[SELECT ONE]");
		
		NoticeDto dto = biz.selectOne(notice_no);
		model.addAttribute("dto", dto);
		
		return "notice_detail";
	}
	
	@RequestMapping(value="/insert")
	public String insertForm() {
		logger.info("[INSERT FORM]");
		
		return "notice_insert";
	}
	
	@RequestMapping(value="/insertres")
	public String insertRes(NoticeDto dto, Model model) {
		logger.info("[INSERT RES]");
		
		int res = biz.insert(dto);
		if (res > 0) {
			model.addAttribute("list", biz.selectList());
			return "notice";
		}
		
		return "notice_insert";
	}
	
	@RequestMapping(value="/update")
	public String updateForm(Model model, int notice_no) {
		logger.info("[UPDATE FORM");
		
		NoticeDto dto = biz.selectOne(notice_no);
		model.addAttribute("dto", dto);
		
		return "notice_update";
	}
	
	@RequestMapping(value="/updateres")
	public String updateForm(NoticeDto dto) {
		logger.info("[UPDATE RES]");
		
		int res = biz.update(dto);
		if (res > 0) {
			return "redirect:notice";
		} else {
			return "redirect:notice_update?notice_no="+dto.getNotice_no();
		}
	}
	
	@RequestMapping(value="/delete")
	public String delete(int notice_no) {
		logger.info("[DELETE]");
		
		int res = biz.delete(notice_no);
		if (res > 0) {
			return "redirect:notice";
		} else {
			return "redirect:notice_detail?notice_no="+notice_no;
		}
	}
	
}





















