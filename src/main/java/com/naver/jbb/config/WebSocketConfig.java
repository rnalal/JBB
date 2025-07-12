package com.naver.jbb.config;

import java.security.Principal;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.server.support.DefaultHandshakeHandler;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		//클라이언트가 /ws로 연결 요청 -> SockJS 지원
		registry.addEndpoint("/ws")
				.setHandshakeHandler(new DefaultHandshakeHandler() {
					//연결 시 HttpSession의 "id"를 꺼내서 STOMP Principal로 설정
					@Override
					protected Principal determineUser(ServerHttpRequest request, 
													  WebSocketHandler wsHandler, Map<String, Object> attributes) {
						HttpServletRequest servletReq = ((ServletServerHttpRequest) request).getServletRequest();
						HttpSession session = servletReq.getSession(false);
						
						//세션 또는 id가 없으면 anoaymous 사용자로 처리
						if(session == null || session.getAttribute("id") == null) {
							return () -> "anonymous"; 
						}					
						
						String userId = (String) servletReq.getSession().getAttribute("id");
						return () -> userId;
					}
				})
				.withSockJS();
	}
	
	@Override
	public void configureMessageBroker(MessageBrokerRegistry config) {
		// /topic은 전체 브로드캐스트, /queue는 1:1 사용자용
		config.enableSimpleBroker("/topic", "/queue");
		// sendToUser() 호출 시 앞에 붙는 prefix
		config.setUserDestinationPrefix("/user");
		// 클라이언트->서버로 메시지 보낼 때 prefix
		config.setApplicationDestinationPrefixes("/app");
	}
}
