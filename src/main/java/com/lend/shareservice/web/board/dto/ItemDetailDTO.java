package com.lend.shareservice.web.board.dto;

import lombok.Data;

import java.sql.Date;

@Data
public class ItemDetailDTO {

//    "borad_id": 1,
//            "wirter": "John",
//            "title": "대학 물리학 빌리실 분",
//            "content": "대학 물리학 빌릴 사람 ?",
//            "reg_date": "2024-04-29 14:30:28",
//            "deadline": "2024-04-30 14:30:28",
//            "lendDate": null,
//            "returnDate": null,
//            "price": 2500,
//            "isAuction": true,
//            "isLend": "1",
//            "interestCnt": 23,
//            "hits": 51,
//            "item_name": "대학 물리학",
//            "item_image1": "phy1.jpg",
//            "item_image2": "phy2.jpg",
//            "item_image3": "phy3.jpg",
//            "board_category_id": 1,
//            "item_category_id": 2,
//            "latitude": 123.411122,
//            "longitude": 222.1111,
//            "isMegaphone": false

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
    private String itemImage1;
    private String itemImage2;
    private String itemImage3;
    private Integer boardCategory;
    private Integer itemCategoryId;
    private Double latitude;
    private Double longitude;
    private String isMegaphone;

}
