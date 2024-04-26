package com.lend.shareservice.entity;

import lombok.Data;

import javax.validation.constraints.NotNull;

// 채팅방
@Data
public class Favorite {

    // 관심번호 (ID)
    @NotNull
    private Integer favorite_id;

    // 유저 아이디 (FK)
    @NotNull
    private Integer user_id;

    // 글번호 (FK)
    @NotNull
    private Integer board_id;
}
