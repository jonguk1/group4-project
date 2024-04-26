package com.lend.shareservice.entity;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.sql.Date;

// 경매
@Data
public class Auction {

    // 경매번호 (ID)
    @NotNull
    private Integer auction_id;

    // 현재 금액 (default = 0)
    @NotNull
    private Integer current_price;

    // 등록일 (default = sysdate)
    @NotNull
    private Date reg_date;

    // 최대 금액
    @NotNull
    private Integer max_price;

    // 글번호
    @NotNull
    private Integer board_id;

}
