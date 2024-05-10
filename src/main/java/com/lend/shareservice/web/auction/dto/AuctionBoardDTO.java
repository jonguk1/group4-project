package com.lend.shareservice.web.auction.dto;

import lombok.Data;

import java.util.Date;

@Data
public class AuctionBoardDTO {
    private Integer boardId;
    private String title;
    private Date deadline;
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
