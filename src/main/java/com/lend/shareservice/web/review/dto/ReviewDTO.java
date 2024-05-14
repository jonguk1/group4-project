package com.lend.shareservice.web.review.dto;

import com.lend.shareservice.entity.Review;
import lombok.Data;

import java.util.List;

@Data
public class ReviewDTO {
    
    private String content;
    private Integer star;
    private String reviewer;
    private String reviewee;
    private List<Review> reviews;
}
