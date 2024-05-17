package com.lend.shareservice.web.board.dto;

import lombok.Data;

import java.sql.Date;
import java.util.List;

@Data
public class ItemDetailDTO {

    private Integer boardId;
    private String writer;
    private String title;
    private String content;
    private Date regDate;
    private Date deadline;
    private Date lendDate;
    private Date returnDate;
    private String price;
    private String isAuction;
    private String isLend;
    private Integer interestCnt;
    private Integer hits;
    private String itemName;
    private List<String> itemImage;
    private Integer boardCategoryId;
    private Integer itemCategoryId;
    private Double latitude;
    private Double longitude;
    private String isMegaphone;
    private String address;
    private Integer distance;
}
