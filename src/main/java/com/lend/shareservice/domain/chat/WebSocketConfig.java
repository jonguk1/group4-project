package com.lend.shareservice.domain.chat;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketConfigurer {
    // WebSocketHandler 선언 - 웹소켓 통신을 처리해준다.
    private final WebSocketHandler webSocketHandler;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        // endpoint 설정 : /ws/chat
        // 이를 통해서 ws://localhost:9090/ws/chat 으로 요청이 들어오면 websocket 통신을 진행한다.
        // 도메인이 다른 서버에서도 접속 가능하도록 setAllowedOrigins("*")을 해줘서
        // 모든 Cors의 요청을 허용해준다.
        registry.addHandler(webSocketHandler, "/ws/chat").setAllowedOrigins("*");
    }
}
