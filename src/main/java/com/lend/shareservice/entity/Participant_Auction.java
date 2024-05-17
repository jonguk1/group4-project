package com.lend.shareservice.entity;

import jakarta.validation.constraints.PositiveOrZero;
import lombok.Data;

import jakarta.validation.constraints.NotNull;

// 참여자_경매
@Data
public class Participant_Auction {

    // 경매번호 (FK)
    @NotNull
    private Integer auctionId;

    // 아이디 (FK)
    @NotNull
    private String userId;

    // 현재 금액
    @PositiveOrZero
    @NotNull
    private Integer currentPrice;
}
