package com.lend.shareservice.entity;

import lombok.Data;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

// 리뷰
@Data
public class Review {

    // 리뷰 번호
    @NotNull
    private Integer reviewId;

    // 내용
    @NotBlank(message = "리뷰 내용을 입력해주세요")
    @Size(max = 200, message = "글 내용 200자 초과")
    private String content;

    // 별점
    @NotNull
    private Integer star;

    // 작성자 (FK)
    @NotNull
    private String reviewer;

    // 피작성자 (FK)
    @NotNull
    private String reviewee;

}
