package com.lend.shareservice.domain.review;

import com.lend.shareservice.entity.Review;

import java.util.List;

public interface ReviewService {

    public List<Review> receiveds(int limit,int offset,String userId);

    public List<Review> sents(int limit,int offset,String userId);

    public int receivedGetTotalCount(String userId);

    public int sentGetTotalCount(String userId);

}
