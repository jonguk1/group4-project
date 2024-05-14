package com.lend.shareservice.entity;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.sql.Date;

// 경매
@Data
public class Auction {

    // 경매번호 (ID)
    @NotNull
    private Integer auctionId;

    // 현재 금액 (default = 0)
    @NotNull
    private Integer currentPrice;

    // 등록일 (default = sysdate)
    @NotNull
    private Date regDate;

    // 최대 금액
    @NotNull
    private Integer maxPrice;

    // 글번호
    @NotNull
    private Integer boardId;

    // 낙찰자
    private String userId;

}
