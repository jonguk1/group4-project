package com.lend.shareservice.web.user.dto;

import lombok.Data;

@Data
public class ReviewDTO {
    String reviewee;

    public ReviewDTO(String reviewee) {
        this.reviewee = reviewee;
    }
}
