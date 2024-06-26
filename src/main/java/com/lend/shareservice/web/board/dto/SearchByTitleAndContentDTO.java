package com.lend.shareservice.web.board.dto;

import lombok.Data;

@Data
public class SearchByTitleAndContentDTO {

    private Integer boardCategoryId;
    private Integer itemCategoryId;
    private String searchTermDetail;
}
