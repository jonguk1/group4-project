package com.lend.shareservice.web.board.dto;

import jakarta.validation.constraints.*;
import lombok.Data;
import org.springframework.beans.factory.annotation.Value;

import java.sql.Date;

@Data
public class PostDTO {

    // 글 번호 (ID)
    @NotNull
    private Integer boardId;

    // 글 카테고리 (FK)
    @NotNull
    private Integer boardCategoryId;

    // 작성자 (FK)
    @NotNull
    private String writer;

    // 글 제목
    @NotEmpty
    @Size(max = 100, message = "글 내용 100자 초과")
    private String title;

    // 내용
    @NotEmpty
    @Size(max = 3000, message = "글 내용 3000자 초과")
    private String content;

    // 작성일 (default = sysdate)
    @NotNull
    private Date regDate;

    // 판매 금액
    @PositiveOrZero
    @NotNull
    private String price;

    // 경매 마감 시간 (경매 가능인 글에서만 설정)
    @Future
    private Date deadline;

    // 경매 여부 (0 : 경매 전(아직 인원수가 모이지 않음), 1 : 경매 중(마감 시간 전까지 경매가 진행중), 2 : 경매 완료(낙찰이 되어 경매가 종료됨))
    @NotNull
    private String isAuction;

    // 대여 여부 (0 : 대여 전, 1 : 대여 중(1대1 약속이 정해져 예약이 확정됨), 2 : 대여 완료(실제 물건을 대여함))
    @NotNull
    private String isLend;

    // 관심수 (default = 0)
    @PositiveOrZero
    @NotNull
    private Integer interestCnt;

    // 조회수 (default = 0)
    @PositiveOrZero
    @NotNull
    private Integer hits;

    private Date lendDate;

    // 반납날짜
    @Future
    private Date returnDate;

    // 상품명
    @NotBlank
    @Size(max = 30, message = "상품명 30자 초과")
    private String itemName;



    // 물건카테고리 번호 (FK)
    @NotNull
    private Integer itemCategoryId;

    // 위도
    @NotNull
    private Double latitude;

    // 경도
    @NotNull
    private Double longitude;

    // 확성기 여부
    @NotNull
    private String isMegaphone;

    private String address;

    private String imgSrc;

    private String currentState;

    private Integer distance;
}
