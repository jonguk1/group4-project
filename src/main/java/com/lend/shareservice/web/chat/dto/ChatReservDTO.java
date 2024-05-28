package com.lend.shareservice.web.chat.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ChatReservDTO {
    private Double reservLat;
    private Double reservLong;
    private Integer chatId;
    private String from;
    private String to;
    private String content;
    private String sendTime;
    private String selectedDateTime;
}
