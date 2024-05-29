package com.lend.shareservice.web.chat.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Date;

@Data
@AllArgsConstructor
public class ReservLatiLongDTO {

    private double latitude; // 약속된 위도
    private double longitude; // 약속된 경도
    private Integer messageId; // 메세지 아이디
    private String selectedDateTime; // 약속된 날짜

}
