package com.lend.shareservice.web.chat.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReservLatiLongDTO {

    private double latitude; // 위도
    private double longitude; // 경도
    private Integer messageId; // 메세지 아이디


}
