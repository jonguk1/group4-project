package com.lend.shareservice.domain.chat;
// 채팅 서비스 구현
// 채팅방을 생성, 조회하고 하나의 세션에 메시지 발송을 하는 서비스를 구현
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;
import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class ChatServiceImpl {

    private final ChatMapper chatMapper;
    private final ObjectMapper objectMapper;
    //JSON 컨텐츠를 Java 객체로 역직렬화(deserialization)하거나
    //Java 객체를 JSON으로 직렬화(serialization)할 때 사용하는 Jackson 라이브러리 클래스
    private Map<String, ChatRoomDTO> chatRooms;
    //서버에 생성된 모든 채팅방의 정보를 모아둔 구조체, 빠른 구현을 위해 일단 HashMap에 저장하는것으로 구현

    @PostConstruct //의존성 주입이 이루어진 후 초기화를 수행하는 메서드
    private void init(){
        chatRooms = new LinkedHashMap<>();
    }

    public List<ChatRoomDTO> findAllRoom(){
        return new ArrayList<>(chatRooms.values());
    }

    // 채팅방 조회 - 채팅방 Map에 담긴 정보를 조회.
    public ChatRoomDTO findRoomById(String roomId){
        return chatRooms.get(roomId);
    }

    // 채팅방 생성 - Random UUID로 구별ID를 가진 채팅방 객체를 생성하고 채팅방 Map에 추가
    public ChatRoomDTO createRoom(String name){
        String randomId = UUID.randomUUID().toString();
        //UUID : Universally Unique IDentifier의 약어, 범용 고유 식별자
        //네트워크 상에서 고유성이 보장되는 id를 만들기 위한 표준 규약
        //분산 컴퓨팅 환경에서 사용되는 식별자, 개별 시스템이 id를 발급하더라도 유일성이 보장되어야하기에 탄생
        ChatRoomDTO chatRoom = ChatRoomDTO.builder()
                .roomId(randomId)
                .roomName(name)
                .build();
        chatRooms.put(randomId,chatRoom);
        return chatRoom;
    }

    // 메시지 발송 - 지정한 Websocket 세션에 메시지를 발송
    public <T> void sendMessage(WebSocketSession session, T message){
        try{
            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
        }catch (IOException e){
            log.error(e.getMessage(), e);
        }
    }

}
