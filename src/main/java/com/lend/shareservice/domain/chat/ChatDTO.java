package com.lend.shareservice.domain.chat;
//채팅 메시지 구현을 위한 DTO
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatDTO {
    // 메세지 타입 : 입장, 채팅
    public enum MessageType{
    //enum : 열거형 - 서로 연관된 상수들의 집합, 이 값들이 변경되지 않도록 보장
        ENTER, TALK
    }
    private MessageType type; // 메세지 타입
    private String  roomId; //채팅방번호
    private String sender; // 메시지 보낸 사람
    private String message; // 메시지
}
