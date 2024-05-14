package com.lend.shareservice.entity;

import lombok.Data;

import jakarta.validation.constraints.NotNull;

// 물건 카테고리
@Data
public class Item_Category {

    // 물건 카테고리 번호 (ID)
    @NotNull
    private Integer itemCategoryId;

    // 카테고리명
    private String itemCategoryName;
}
