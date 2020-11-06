package com.minibean.timewizard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.minibean.timewizard.model.biz.ReplyBiz;
import com.minibean.timewizard.model.dto.ReplyDto;

@RestController
@RequestMapping(value = "/reply")
public class ReplyController {

	private Logger logger = LoggerFactory.getLogger(ReplyController.class);

	@Autowired
	private ReplyBiz replyBiz;

	@RequestMapping(value = "/replylist", method = RequestMethod.POST)
	public List<ReplyDto> replyList(@RequestParam("notice_no") int notice_no) {
		
		logger.info("< Reply List > ");
		return replyBiz.replyList(notice_no);
	}

	@RequestMapping(value = "/insertreply", method = RequestMethod.POST)
	public Map<String, Object> insertReply(@RequestBody ReplyDto dto) throws Exception {

		logger.info("< Insert Reply>");
		Map<String, Object> result = new HashMap<>();

		try {

			replyBiz.insertReply(dto);
			result.put("status", "OK");

		} catch (Exception e) {

			e.printStackTrace();
			result.put("status", "False");
		}

		return result;

	}

}
