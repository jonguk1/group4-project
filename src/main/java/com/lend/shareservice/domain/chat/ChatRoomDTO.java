package com.lend.shareservice.domain.chat;
//채팅방 구현을 위한 DTO
import lombok.Builder;
import lombok.Getter;
import org.springframework.web.socket.WebSocketSession;

import java.util.HashSet;
import java.util.Set;

@Getter
public class ChatRoomDTO {
    private String roomId; //채팅방 번호
    private String roomName; //채팅방 이름
    //입장한 클라이언트들의 정보를 가지고 있을 WebsocketSession 정보 리스트
    private Set<WebSocketSession> sessions = new HashSet<>(); //현재 연결된 세션들

    @Builder
    public ChatRoomDTO(String roomId, String roomName){
        this.roomId = roomId;
        this.roomName = roomName;
    }

    // if문으로 입장과 대화를 분기 chatServiceImpl
    public void handleActions(WebSocketSession session, ChatDTO chatDTO, ChatServiceImpl chatServiceImpl){
        if(chatDTO.getType().equals(ChatDTO.MessageType.ENTER)){
            sessions.add(session);
            chatDTO.setMessage(chatDTO.getSender()+"님이 입장했습니다.");
        }
        sendMessage(chatDTO,chatServiceImpl);
    }

    //해당 채팅방에 있는 session에 메시지를 전송
    public <T> void sendMessage(T message, ChatServiceImpl chatServiceImpl){
        sessions.parallelStream().forEach(session -> chatServiceImpl.sendMessage(session, message));
    }

}
