package com.lend.shareservice.domain.chat;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lend.shareservice.web.chat.dto.ChatDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class RedisSubscriber implements MessageListener {
    private final ObjectMapper objectMapper;
    private final RedisTemplate<String, Object> redisTemplate;
    private final SimpMessageSendingOperations messagingTemplate;

    // Redis 에서 메시지가 발행(publish)되면, listener 가 해당 메시지를 읽어서 처리
    @Override
    // onMessage : Redis의 pub/sub 구독자로부터 메세지 수신할때마다 호출됨
    public void onMessage(Message message, byte[] pattern) {//pattern : Redis 에서 메시지를 수신한 패턴(특정 채널 이름)
        try {
            // redis 에서 발행된 데이터를 받아 역직렬화
            String publishMessage = (String) redisTemplate.getStringSerializer().deserialize(message.getBody());

            // 해당 객체를 ChatDto 객체로 맵핑
            // objectMapper : JSON 데이터를 Java 객체로 변환
            ChatDTO chatDTO = objectMapper.readValue(publishMessage, ChatDTO.class);

            // Websocket 구독자에게 채팅 메시지 전송
            //@SendTo의 경로와 일치해야함
            messagingTemplate.convertAndSend("/topic/messages/", chatDTO);
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

}
