package com.minibean.timewizard.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.dao.ChatDao;

@Service // Biz
public class ChatServiceImpl implements ChatService{

	@Autowired
	ChatDao dao;

}
