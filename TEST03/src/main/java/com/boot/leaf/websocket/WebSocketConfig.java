package com.boot.leaf.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSocket
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketConfigurer{

	@Autowired
	private WebSocketHandler webSocketHandler = new WebSocketHandler();
	@Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
     registry.addHandler(webSocketHandler,"/webserver").setAllowedOrigins("*").withSockJS();
		
    }	

}
