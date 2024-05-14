package com.lend.shareservice.web.auction.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.sql.Date;

@Data
public class AuctionBoardDTO {
    private Integer boardId;
    private String title;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Timestamp deadline;

    private String itemImage1;
    private Integer price;
    private String itemName;
    private Integer interestCnt;
    private Integer hits;
    private String isAuction;
    private String isLend;
    private Double latitude;
    private Double longitude;

}
