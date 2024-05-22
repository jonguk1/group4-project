package com.lend.shareservice.web.chat.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class OutputMessageVo {

    private String lendy; //메세지 보낸 사람
    private String lender; //메세지 받는 사람
    private String content; // 메세지 내용
    private int chatId; // 채팅방 번호
    private String sendTime; // 메세지 보낸 시간

    public OutputMessageVo(String lendy, String lender, String content, String sendTime) {
        this.lendy = lendy;
        this.lender = lender;
        this.content = content;
        this.sendTime = sendTime;
    }
}
