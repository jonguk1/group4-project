package com.lend.shareservice.web.chat.dto;

import lombok.*;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ChatListItemDTO {

    private String from; //메세지 보낸 사람
    private String to; //메세지 받는 사람
    private String content; // 메세지 내용
    private int chatId; // 채팅방 번호
    private Date sendTime; // 메세지 보낸 시간
    private boolean isRead; // 읽음여부
    private Integer boardId; //게시글번호
    private ChatItemDTO chatItemDTO;
}
