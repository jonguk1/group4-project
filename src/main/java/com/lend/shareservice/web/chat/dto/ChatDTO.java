package com.lend.shareservice.web.chat.dto;
//채팅 메시지 구현을 위한 DTO
import lombok.*;

@Data
public class ChatDTO {
   // private String status;//#100=>입장, #200 DB에서 가져온 내용 보내기, #300 일반 대화메시지 #400 퇴장
    private String from; //메세지를 보내는 사람
    private String to; //메세지 받는 사람
    private String content; // 메세지 내용
    private int chatId; // 채팅방 번호
    private String sendTime; // 메세지 보낸 시간

}
