package com.lend.shareservice.entity;

import lombok.Data;

import jakarta.validation.constraints.NotNull;

import java.util.Date;

@Data
public class Chatroom {

    // 채팅방번호 (ID)
    @NotNull
    private Integer chat_id;

    // 글번호 (FK)
    @NotNull
    private Integer writing_no;

    // 구매자 (FK)
    @NotNull
    private String lendy;

    // 판매자 (FK)
    @NotNull
    private String lender;

    // 채팅방 생성일
    @NotNull
    private Date chat_date;

    // 위도
    private Double latitude;

    // 경도
    private Double longtitude;

    // 예약날짜
    private Date Reservation;


}
