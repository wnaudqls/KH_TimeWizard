package com.minibean.timewizard.websocket.handler;


import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.minibean.timewizard.message.ChatMessage;
import com.minibean.timewizard.model.biz.ChatBiz;
import com.minibean.timewizard.model.biz.ChatBizImpl;
import com.minibean.timewizard.model.dto.ChatDto;




public class EchoHandler extends TextWebSocketHandler {
	@Autowired
	private ChatBiz biz  = new ChatBizImpl();
	
    private ObjectMapper objectMapper = new ObjectMapper();
    
    Logger log =  LoggerFactory.getLogger(EchoHandler.class);
    
    public Set<WebSocketSession> sessionList = new HashSet<WebSocketSession>();
    
    public EchoHandler() {


	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		// sessionList에 저장
    	sessionList.add(session);
    	log.info("[Echo]: "+sessionList);
		// 누가 연결되었는지 콘솔창에 띄움
		log.info("{} 연결됨", session.getId());
	}

	// 클라이언트가 접속을 끊었을때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub

		// 접속을 끊은 session을 sessionList에서 지움
		sessionList.remove(session);

		// 누가 연결을 끊었는지 콘솔창에 띄움
		log.info("{} 연결 끊김", session.getId());
	}
    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	log.info("메세지 전송 = {} : {}",session,message.getPayload());
        String msg = message.getPayload();
        log.info("msg: "+msg);
        ChatMessage chatMessage = objectMapper.readValue(msg,ChatMessage.class);
        log.info("chatMessage: "+chatMessage);
        ChatDto chatdto;
        log.info("getRoomId: "+chatMessage.getRoomid());
		  chatdto = biz.findRoomById(chatMessage.getRoomid());
		        
		/*
		 * chatdto = biz.selectOne(chatMessage.getRoomid());
		 */	log.info("방번호: "+chatdto);
		 chatdto.handleMessage(session,chatMessage,objectMapper);
    }

	public Set<WebSocketSession> getSessionList() {
		return sessionList;
	}

	public void setSessionList(Set<WebSocketSession> sessionList) {
		this.sessionList = sessionList;
	}
}