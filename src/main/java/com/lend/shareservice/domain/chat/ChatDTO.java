package com.lend.shareservice.domain.chat;
//채팅 메시지 구현을 위한 DTO
import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ChatDTO {
    // 메세지 타입 : 입장, 채팅
    // 메시지 타입에 따라 동작하는 구조 달라짐
    // 입장과 퇴장 ENETER과 LEAVE의 경우 입장/퇴장 이벤트 처리 실행
    // TALK 해당 채팅방을 SUB하고 있는 모든 클라이언트에게 전달

    public enum MessageType {
    //enum : 열거형 - 서로 연관된 상수들의 집합, 이 값들이 변경되지 않도록 보장
        ENTER, TALK, LEAVE
    }
    private MessageType type; // 메세지 타입
    private String roomId; //채팅방 아이디 - 수정 예정
    private String sender; // 메시지 보낸 사람
    private String message; // 메시지
    private String time; // 채팅 발송 시간
}
