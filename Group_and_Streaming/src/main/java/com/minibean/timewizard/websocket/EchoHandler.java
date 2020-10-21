package com.minibean.timewizard.websocket;

import java.util.ArrayList;
import java.util.List;

import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

//연결할 주소
@ServerEndpoint("/webserver.do")
public class EchoHandler extends TextWebSocketHandler {
//TextWebSocketHandler를 상속받아야함

	// WebSocketSession을 저장할 List를 생성
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	// Logger 생성
	private Logger logger = LoggerFactory.getLogger(EchoHandler.class);

	// 클라이언트가 접속했을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 접속한 클라이언트의 session을 저장
		sessionList.add(session);

		// 접속한 sessionId 띄움
		logger.info("{} 접속, 현재 클라이언트 숫자: {}", session.getId(), sessionList.size());
	}

	// 서버로부터 메세지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		logger.info("\n세선id: {}\n{}", session.getId(), message.getPayload());

		for (WebSocketSession wss : sessionList) {
			// 전체에게 메세지 전달
			wss.sendMessage(new TextMessage(message.getPayload()));
		}
	}

	// 클라이언트가 접속을 끊었을때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		// 어떤 session이 접속을 끊었는지 띄움
		logger.info("{} 접속 해제", session.getId());
		// 해당 session을 List에서 삭제
		sessionList.remove(session);

	}

	// 연결된 클라이언트에서 예외 발생 시 실행
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		// TODO Auto-generated method stub
		super.handleTransportError(session, exception);
	}

}
