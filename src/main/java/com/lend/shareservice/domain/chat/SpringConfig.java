package com.lend.shareservice.domain.chat;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

// Stomp 엔드 포인트 → sub/pub 엔드 포인트 설정
// 엔드 포인트: 통신의 도착 지점
@Configuration
@EnableWebSocketMessageBroker
public class SpringConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry)
    {
        // stomp 접속 주소 url => /ws-stomp
        registry.addEndpoint("/ws-stomp") // 연결될 엔드 포인트
                .withSockJS(); // SocketJS를 연결한다는 설정
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry)
    {
        // 메시지를 구독하는 요청 url => 메시지 받을 때
        registry.enableSimpleBroker("/sub");

        // 메시지를 발행하는 요청 url => 메시지 보낼 때
        registry.setApplicationDestinationPrefixes("/pub");
    }
}
