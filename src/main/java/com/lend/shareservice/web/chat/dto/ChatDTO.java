package com.lend.shareservice.web.chat.dto;
//채팅 메시지 구현을 위한 DTO
import lombok.*;

@Data
@Getter
@Setter
public class ChatDTO {
    private String content; // 메세지 내용
    private String sender; // 메시지 보낸 사람
    private String target; // 메세지 받는 사람
}
