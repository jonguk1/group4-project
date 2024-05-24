package com.lend.shareservice.domain.chat;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

// Stomp 엔드 포인트 → sub/pub 엔드 포인트 설정
// 엔드 포인트: 통신의 도착 지점
@Configuration
@EnableWebSocketMessageBroker //Stomp 사용을 위해 선언받고 아래에 상속받음
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry)
    {
        // 브라우저: ws: //localhost:8081/chat → socketjs에서 접속할 때 사용(sockjs 연결 주소)
        registry.addEndpoint("/chatCon")// 연결될 엔드 포인트
                .setAllowedOrigins("http://localhost:8081")
                .withSockJS(); // SocketJS를 연결한다는 설정
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry)
    {
        // 메시지를 구독하는 요청 url(prefix) => 메시지 받을 때
        registry.enableSimpleBroker("/topic");

        // 메시지를 발행하는 요청 url(prefix) => 메시지 보낼 때
        registry.setApplicationDestinationPrefixes("/app");
    }
}
