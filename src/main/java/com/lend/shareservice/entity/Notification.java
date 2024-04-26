package com.lend.shareservice.entity;

import javax.validation.constraints.NotNull;
import java.sql.Date;

public class Notification {

    // 알림 번호 (ID)
    @NotNull
    private Integer noti_id;

    // 유저 아이디 (FK)
    @NotNull
    private String user_id;

    // 내용
    @NotNull
    private String content;

    // 읽음 여부 (default = false)
    @NotNull
    private Boolean isRead;

    // 생성일자 (default = sysdate)
    @NotNull
    private Date noti_reg_date;


}
