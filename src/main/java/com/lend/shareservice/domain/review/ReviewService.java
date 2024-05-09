package com.lend.shareservice.domain.review;

import com.lend.shareservice.entity.Review;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.review.dto.ReviewDTO;

import java.util.List;

public interface ReviewService {

    List<ReviewDTO> receiveds(PagingDTO page, String userId);

    List<ReviewDTO> sents(PagingDTO page,String userId);

    int receivedGetTotalCount(String userId);

    int sentGetTotalCount(String userId);

}
