package com.lend.shareservice.domain.review;

import com.lend.shareservice.entity.Review;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.review.dto.ReviewDTO;
import com.lend.shareservice.web.review.dto.ReviewRegDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService{

    private final ReviewMapper reviewMapper;

    @Override
    public List<ReviewDTO> findByReceivedList(PagingDTO page, String userId) {
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return reviewMapper.findByReceivedList(map);
    }

    @Override
    public List<ReviewDTO> findBySentList(PagingDTO page, String userId) {
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return reviewMapper.findBySentList(map);
    }

    @Override
    public int receivedGetTotalCount(String userId) {
        return reviewMapper.receivedGetTotalCount(userId);
    }

    @Override
    public int sentGetTotalCount(String userId) {
        return reviewMapper.sentGetTotalCount(userId);
    }

    // 리뷰 등록
    @Override
    public int registerReview(ReviewRegDTO reviewRegDTO) {
        Review review = new Review(reviewRegDTO.getReviewer(), reviewRegDTO.getReviewee(), reviewRegDTO.getContent(), reviewRegDTO.getStar());
        return reviewMapper.saveReview(review);
    }


}
