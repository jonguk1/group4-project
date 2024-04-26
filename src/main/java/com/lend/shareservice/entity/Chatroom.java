package com.lend.shareservice.entity;

import lombok.Data;

import javax.validation.constraints.NotNull;

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

}
