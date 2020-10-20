package com.mvc.upgrade.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.upgrade.model.biz.BoardBiz;
import com.mvc.upgrade.model.dto.BoardDto;
import com.mvc.upgrade.model.dto.PagingDto;

@Controller
public class BoardController {
	
	@Autowired
	private BoardBiz boardBiz;
	
	private Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping(value="/list.do")
	public String selectList(Model model,PagingDto pagingDto,
				@RequestParam("nowpage")String nowpage, 
				@RequestParam("cntPerpage")String cntPerpage) {
		logger.info("[list.do]");
		
		int total = boardBiz.countBoard();
		if(nowpage == null && cntPerpage == null) {
			nowpage = "1";
			cntPerpage = "5";
		}else if(nowpage == null) {
			nowpage = "1";
		}else if(cntPerpage == null) {
			cntPerpage = "5";
		}
		
		pagingDto = new PagingDto(total, Integer.parseInt(nowpage), Integer.parseInt(cntPerpage));
		
		model.addAttribute("paging",pagingDto);
		model.addAttribute("list", boardBiz.selectList(pagingDto));
		
		return "mvclist";
	}
	
	@RequestMapping(value="/detail.do")
	public String selectOne(Model model, int myno,
			PagingDto pagingDto,
			@RequestParam("nowpage")String nowpage, 
			@RequestParam("cntPerpage")String cntPerpage) {
		logger.info("[detail.do]");
		
		model.addAttribute("paging", pagingDto);
		model.addAttribute("dto", boardBiz.selectOne(myno));
		
		return "mvcdetail";
	}
	
	@RequestMapping(value="/insert.do")
	public String insert(Model model, PagingDto pagingDto) {
		
		model.addAttribute("paging",pagingDto);
		
		return "mvcinsert";
	}
	
	@RequestMapping(value="/insertres.do")
	public String insertres(Model model, BoardDto dto,
			PagingDto pagingDto,
			@RequestParam("nowpage")String nowpage, 
			@RequestParam("cntPerpage")String cntPerpage) {
		logger.info("[insertres.do]");
		
		
		int res = boardBiz.insert(dto);
		
		if(res > 0) {
			return "redirect:list.do?nowpage="+nowpage+"&cntPerpage="+cntPerpage;
		}
				
		return "mvcinsert";
	}
	
	@RequestMapping(value="/update.do")
	public String update(Model model, int myno, PagingDto pagingDto) {
		logger.info("[update.do]");
		
		BoardDto dto = boardBiz.selectOne(myno);
		
		model.addAttribute("paging", pagingDto);
		model.addAttribute("dto", dto);
		
		return "mvcupdate";
	}
	
	@RequestMapping(value="/updateres.do")
	public String updateres(Model model, BoardDto dto, int myno,
			@RequestParam("nowpage")String nowpage, 
			@RequestParam("cntPerpage")String cntPerpage) {
		logger.info("[updateres.do]");
		
		int res = boardBiz.update(dto);
		
		if(res > 0) {
			return "redirect:detail.do?myno="+dto.getMyno()+"&nowpage="+nowpage+"&cntPerpage="+cntPerpage;
		}
		
		return "redirect:update.do?myno="+dto.getMyno();
	}
	
	@RequestMapping(value="/delete.do")
	public String delete(Model model, int myno,
			@RequestParam("nowpage")String nowpage, 
			@RequestParam("cntPerpage")String cntPerpage) {
		logger.info("[delete.do]");
		
		int res = boardBiz.delete(myno);
		
		if(res > 0) {
			return "redirect:list.do?nowpage="+nowpage+"&cntPerpage="+cntPerpage;
		}
		return "redirect:detail.do?myno="+myno;
	}

}
