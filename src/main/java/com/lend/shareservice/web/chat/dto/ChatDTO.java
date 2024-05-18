package com.lend.shareservice.web.chat.dto;
//채팅 메시지 구현을 위한 DTO
import com.lend.shareservice.entity.Message;
import lombok.*;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ChatDTO {

    private String from; // 메세지 작성자
    private String to; // 메세지 수신자
    private String content; // 메세지 내용
    private int chatId; // 채팅방 번호
    private String sendTime; // 메세지 보낸 시간

}
