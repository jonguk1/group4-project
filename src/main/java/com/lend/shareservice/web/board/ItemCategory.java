package com.lend.shareservice.web.board;

public enum ItemCategory {
    BOOK("도서"),
    HOUSEHOLD("생활용품"),
    MENCLOTHING("남성의류"),
    WOMENCLOTHING("여성의류"),
    DIGITALDEVICE("디지털기기");

    private final String categoryName;
    private ItemCategory(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryName() {
        return categoryName;
    }
}
