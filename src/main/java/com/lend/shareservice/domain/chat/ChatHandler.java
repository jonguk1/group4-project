package com.lend.shareservice.domain.chat;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

/*
 * WebSocket Handler 작성
 * 소켓 통신은 서버와 클라이언트가 1:n으로 관계를 맺는다. 따라서 한 서버에 여러 클라이언트 접속 가능
 * 서버에는 여러 클라이언트가 발송한 메세지를 받아 처리해줄 핸들러가 필요
 * TextWebSocketHandler를 상속받아 핸들러 작성
 * 클라이언트로 받은 메세지를 log로 출력하고 클라이언트로 환영 메세지를 보내줌
 * */
@Slf4j
@Component
@RequiredArgsConstructor
public class ChatHandler extends TextWebSocketHandler {

    private final ObjectMapper objectMapper;
    private final ChatServiceImpl chatService;

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
        String payload = message.getPayload();
        log.info("payload {}", payload);
        // TextMessage textMessage = new TextMessage("Welcome!!This is Chat Server");
        // session.sendMessage(textMessage);
        // 웹소켓 클라이언트로부터 채팅 메세지를 전달받아 채팅 메시지 객체로 변환
        ChatDTO chatMessage = objectMapper.readValue(payload, ChatDTO.class);
        //전달 받은 메세지에 담긴 채팅방 ID로 발송 대상 채팅방 정보를 조회함
        ChatRoomDTO room = chatService.findRoomById(chatMessage.getRoomId());
        //해당 채팅방에 입장해있는 모든 클라이언트들(Websocket session)에게 타입에 따른 메세지 발송
        room.handleActions(session, chatMessage, chatService);

    }

}
