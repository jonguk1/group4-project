package com.lend.shareservice.web.user.dto;

import com.lend.shareservice.entity.Chatroom;
import lombok.Data;

import java.sql.Date;
import java.util.List;

@Data
public class MyLenderAndMyLendyDTO {

    private String writer;
    private Integer boardId;
    private String title;
    private String content;
    private Integer price;
    private String isAuction;
    private String isLend;
    private Integer interestCnt;
    private Integer hits;
    private String itemName;
    private String itemImage1;
    private String address;
    private Date regDate;
    private Date returnDate;
    private Double latitude;
    private Double longitude;
    List<Chatroom> chatrooms;
}
