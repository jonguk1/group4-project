package com.lend.shareservice.entity;

import lombok.*;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.util.Date;

// 메시지
@Data
public class Message {

    //메세지 아이디 (ID)
    @NotNull
    private Integer messageId;

    // 채팅방번호
    @NotNull
    private Integer chatId;

    // 보낸사람 (FK)
    @NotNull
    private String from;

    // 받는사람 (FK)
    @NotNull
    private String to;

    // 메세지 내용
    private String content;

    // 보낸 시간 (default = sysdate)
    @NotNull
    private Date sendTime;

    // 확인 여부 (default = false)
    @NotNull
    private Boolean isRead;

    // 이미지1
    @Size(max = 50, message = "파일명 50자 초과")
    private String image1;

    // 이미지2
    @Size(max = 50, message = "파일명 50자 초과")
    private String image2;

    // 이미지3
    @Size(max = 50, message = "파일명 50자 초과")
    private String image3;

    // 이미지4
    @Size(max = 50, message = "파일명 50자 초과")
    private String image4;

    // 이미지5
    @Size(max = 50, message = "파일명 50자 초과")
    private String image5;

    // 위도
    private Double latitude;

    // 경도
    private Double longitude;

    // 예약 날짜
    private Date reservation;

}
