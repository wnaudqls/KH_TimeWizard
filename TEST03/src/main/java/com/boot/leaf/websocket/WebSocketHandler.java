package com.boot.leaf.websocket;


import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.boot.leaf.dao.ChatRoomRepository;
import com.boot.leaf.dto.ChatMessage;
import com.boot.leaf.dto.ChatRoom;
import com.boot.leaf.dto.MessageType;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;




@Slf4j
@Component
@RequiredArgsConstructor
public class WebSocketHandler extends TextWebSocketHandler {
	@Autowired
	private ChatRoomRepository chatRoomRepository = new ChatRoomRepository();
	
    private ObjectMapper objectMapper = new ObjectMapper();
    
  

    Logger log =  LoggerFactory.getLogger(WebSocketHandler.class);
    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    @Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		// sessionList에 저장
		sessionList.add(session);

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
        ChatRoom chatRoom;
        chatRoom = chatRoomRepository.findRoomById(chatMessage.getChatRoomId());
        log.info("objectMapper: "+ objectMapper + "\nsession: " + session);
        chatRoom.handleMessage(session,chatMessage,objectMapper);
      
        
        
    }

}