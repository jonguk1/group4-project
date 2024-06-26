package com.lend.shareservice.web.review.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class ReviewRegDTO {


    String reviewer;

    String reviewee;

    @NotNull(message = "별점을 선택해주세요")
    @Positive(message = "별점을 선택해주세요")
    Integer star;

    @NotEmpty(message = "리뷰내용을 입력해주세요")
    @Size(max = 200, message = "글 내용 200자 초과")
    String content;
}
