package com.lend.shareservice.entity;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.sql.Date;

@Data
public class Notification {

    // 알림 번호 (ID)
    @NotNull
    private Integer notiId;

    // 유저 아이디 (FK)
    @NotNull
    private String userId;

    // 내용
    @NotNull
    private String content;

    // 읽음 여부 (default = false)
    @NotNull
    private Boolean isRead;

    // 생성일자 (default = sysdate)
    @NotNull
    private Date notiRegDate;

    // 글번호
    @NotNull
    private Integer boardId;


}
