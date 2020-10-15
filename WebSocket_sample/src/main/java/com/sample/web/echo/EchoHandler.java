package com.sample.web.echo;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

//연결할 주소
@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler{
	
	//TextWebSocketHandler를 꼭 상속받아야함
	
	//세션 리스트
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	//logger 설정
	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	
	//클라이언트가 접속되었을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		//sessionList에 저장
		sessionList.add(session);
		
		//누가 연결되었는지 콘솔창에 띄움
		logger.info("{} 연결됨",session.getId());
	}
	
	//클라이언트가 웹소켓 서버에 메세지를 전달했을때 실행하는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		
		//메세지를 보낸 session의 아이디와 메세지 내용을 콘솔창에 띄움
		logger.info("{}로 부터 {} 받음",session.getId(), message.getPayload());
		
		//sessionList에 있는 session들을 WebSocketSession타입인 wss에 저장
		for(WebSocketSession wss: sessionList) {
			
			//전체 유저에게 띄워줌
			wss.sendMessage(new TextMessage(message.getPayload()));
		}
	}
	
	
	//클라이언트가 접속을 끊었을때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		
		//접속을 끊은 session을 sessionList에서 지움
		sessionList.remove(session);
		
		//누가 연결을 끊었는지 콘솔창에 띄움
		logger.info("{} 연결 끊김",session.getId());
	}
}
