package com.lend.shareservice.entity;

import lombok.Data;

import jakarta.validation.constraints.NotNull;

// 글 카테고리
@Data
public class Board_Category {

    // 글 카테고리 번호 (ID)
    @NotNull
    private Integer boardCategoryId;

    // 카테고리명
    @NotNull
    private String categoryName;

}
