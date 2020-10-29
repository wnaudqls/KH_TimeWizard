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
import com.minibean.timewizard.model.dto.NoticeDto;
import com.minibean.timewizard.model.dto.PagingDto;

@Controller
public class NoticeController {
	
	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	NoticeBiz biz = new NoticeBizImpl();
	
	
	@RequestMapping(value="/notice")
	public String noticeList(Model model, 
			PagingDto pagingdto, 
			@RequestParam("nowpage")String nowpage,
			@RequestParam("cntPerpage")String cntPerpage ) {
		logger.info("[LIST]");
		
		int total = biz.countNotice();
		if(nowpage == null && cntPerpage == null) {
			nowpage = "1";
			cntPerpage = "5";
		}else if(nowpage == null) {
			nowpage = "1";
		}else if(cntPerpage == null) {
			cntPerpage = "5";
		}
		
		pagingdto = new PagingDto(total, Integer.parseInt(nowpage), Integer.parseInt(cntPerpage));
		
		model.addAttribute("paging", pagingdto);
		model.addAttribute("list", biz.selectList(pagingdto));
		
		return "notice";
	}
	
	@RequestMapping(value="/detail")
	public String detail(Model model, 
			@RequestParam("notice_no") int notice_no,
			PagingDto pagingdto, 
			@RequestParam("nowpage")String nowpage,
			@RequestParam("cntPerpage")String cntPerpage) {
		logger.info("[SELECT ONE]");
		
		NoticeDto dto = biz.selectOne(notice_no);
		
		model.addAttribute("dto", dto);
		model.addAttribute("paging", pagingdto);
		
		return "notice_detail";
	}
	
	@RequestMapping(value="/insert")
	public String insertForm(Model model, PagingDto pagingdto) {
		logger.info("[INSERT FORM]");
		
		model.addAttribute("paging", pagingdto);
		
		return "notice_insert";
	}
	
	@RequestMapping(value="/insertres")
	public String insertRes(NoticeDto dto, Model model,
			PagingDto pagingdto,
			@RequestParam("nowpage")String nowpage,
			@RequestParam("cntPerpage")String cntPerpage) {
		logger.info("[INSERT RES]");
		
		int res = biz.insert(dto);
		if (res > 0) {
			
			return "redirect:notice?nowpage="+nowpage+"&cntPerpage="+cntPerpage;
		}
		
		return "notice_insert";
	}
	
	@RequestMapping(value="/update")
	public String updateForm(Model model, int notice_no, PagingDto pagingdto) {
		logger.info("[UPDATE FORM");
		
		NoticeDto dto = biz.selectOne(notice_no);
		model.addAttribute("dto", dto);
		model.addAttribute("paging", pagingdto);
		
		return "notice_update";
	}
	
	@RequestMapping(value="/updateres")
	public String updateForm(NoticeDto dto,
			@RequestParam("nowpage")String nowpage, 
			@RequestParam("cntPerpage")String cntPerpage) {
		logger.info("[UPDATE RES]");
		
		int res = biz.update(dto);
		if (res > 0) {
			return "redirect:detail?notice_no="+dto.getNotice_no()+"&nowpage="+nowpage+"&cntPerpage="+cntPerpage;
		} else {
			return "redirect:notice_update?notice_no="+dto.getNotice_no();
		}
	}
	
	@RequestMapping(value="/delete")
	public String delete(int notice_no,
			@RequestParam("nowpage")String nowpage, 
			@RequestParam("cntPerpage")String cntPerpage) {
		logger.info("[DELETE]");
		
		int res = biz.delete(notice_no);
		if (res > 0) {
			return "redirect:notice?nowpage="+nowpage+"&cntPerpage="+cntPerpage;
		} else {
			return "redirect:notice_detail?notice_no="+notice_no;
		}
	}
	
}





















