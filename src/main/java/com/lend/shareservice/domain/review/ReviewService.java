package com.lend.shareservice.domain.review;

import com.lend.shareservice.entity.Review;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.review.dto.ReviewDTO;

import java.util.List;

public interface ReviewService {

    List<ReviewDTO> findByReceivedList(PagingDTO page, String userId);

    List<ReviewDTO> findBySentList(PagingDTO page,String userId);

    int receivedGetTotalCount(String userId);

    int sentGetTotalCount(String userId);

}
