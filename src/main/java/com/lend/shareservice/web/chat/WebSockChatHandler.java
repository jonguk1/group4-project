package com.lend.shareservice.web.chat;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

// 여러 클라이언트가 발송한 메시지를 받아 처리해줄 Handler
// Client로부터 받은 메시지를 Console Log에 출력하고 Client로 환영 메시지를 보내는 역할

@Slf4j
@Component
public class WebSockChatHandler extends TextWebSocketHandler {

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        log.info("payload {}", payload);
        TextMessage textMessage = new TextMessage("Welcome chatting sever!!");
        session.sendMessage(textMessage);
    }
}
