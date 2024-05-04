package com.lend.shareservice.domain.review;

import com.lend.shareservice.entity.Review;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.review.dto.ReviewDTO;

import java.util.List;

public interface ReviewService {

    public List<ReviewDTO> receiveds(PagingDTO page, String userId);

    public List<ReviewDTO> sents(PagingDTO page,String userId);

    public int receivedGetTotalCount(String userId);

    public int sentGetTotalCount(String userId);

}
