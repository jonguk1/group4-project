package com.lend.shareservice.entity;

import lombok.Data;

import jakarta.validation.constraints.NotNull;

// 참여자_경매
@Data
public class Participant_Auction {

    // 경매번호 (FK)
    @NotNull
    private Integer auction_id;

    // 아이디 (FK)
    @NotNull
    private String user_id;
}
