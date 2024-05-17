package com.lend.shareservice.web.chat.dto;
//채팅 메시지 구현을 위한 DTO
import com.lend.shareservice.entity.Message;
import lombok.*;

@Data
@Getter
@Setter
@Builder
public class ChatDTO {
    //메세지 타입 설정
    //데이터 관리에 편할 듯 하여 다시 설정해봄
    public enum MessageType{
        ENTER,TALK
    }

    private MessageType type; //메세지 타입
    private String from; // 메세지 작성자
    private String to; //
    private String content; // 메세지 내용
    private int messageId; // 메세지 번호
    private int chatId; // 채팅방 번호
    private String sendTime; // 메세지 보낸 시간

}
