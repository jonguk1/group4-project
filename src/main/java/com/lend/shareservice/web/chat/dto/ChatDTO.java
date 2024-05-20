package com.lend.shareservice.web.chat.dto;
//채팅 메시지 구현을 위한 DTO
import lombok.*;

@Getter
@Setter
public class ChatDTO {

    private String lendy; //메세지 보낸 사람
    private String lender; //메세지 받는 사람
    private String content; // 메세지 내용
    private int chatId; // 채팅방 번호
    private String sendTime; // 메세지 보낸 시간

}
