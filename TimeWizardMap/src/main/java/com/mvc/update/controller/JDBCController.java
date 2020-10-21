package com.mvc.update.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.update.model.biz.JDBCBiz;
import com.mvc.update.model.dto.JDBCDto;

@Controller
public class JDBCController {
	
	@Autowired
	private JDBCBiz jdbcBiz;
	
	@RequestMapping("/list.do")
	public String selectList(Model model) {
		
		model.addAttribute("list", jdbcBiz.selectList());
		
		return "jdbclist";
	}
	
	@RequestMapping(value="/detail.do")
	public String detail(Model model, @RequestParam("seq") int seq) {
		
		JDBCDto dto = jdbcBiz.selectOne(seq);
		model.addAttribute("dto", dto);
		
		return "jdbcdetail";
	}
	
	@RequestMapping("/insert.do")
	public String insertForm() {
		
		return "jdbcinsert";
	}
	
	@RequestMapping("/insertres.do")
	public String insertRes(JDBCDto dto, Model model) {
		
		int res = jdbcBiz.insert(dto);
		if (res > 0) {
			model.addAttribute("list", jdbcBiz.selectList());
			return "jdbclist";
		}
		
		return "jdbcinsert";
	}
	
	@RequestMapping(value="/delete.do")
	public String delete(int seq) {
		
		int res = jdbcBiz.delete(seq);
		if (res > 0) {
			return "redirect:list.do";
		} else {
			return "redirect:detail.do?seq="+seq;
		}
	}
	
	@RequestMapping(value="/update.do")
	public String updateForm(Model model, int seq) {
		
		JDBCDto dto = jdbcBiz.selectOne(seq);
		model.addAttribute("dto", dto);
		
		return "jdbcupdate";
	}
	
	@RequestMapping(value="/updateres.do", method=RequestMethod.POST)
	public String updateRes(JDBCDto dto) {
		
		int res = jdbcBiz.update(dto);
		if (res > 0) {
			return "redirect:detail.do?seq="+dto.getSeq();
		}
		
		return "redirect:update.do?seq="+dto.getSeq();
	}
	

}
