package com.lend.shareservice.domain.review;

import com.lend.shareservice.entity.Review;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.review.dto.ReviewDTO;
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
    public List<ReviewDTO> receiveds(PagingDTO page, String userId) {
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return reviewMapper.receiveds(map);
    }

    @Override
    public List<ReviewDTO> sents(PagingDTO page, String userId) {
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return reviewMapper.sents(map);
    }

    @Override
    public int receivedGetTotalCount(String userId) {
        return reviewMapper.receivedGetTotalCount(userId);
    }

    @Override
    public int sentGetTotalCount(String userId) {
        return reviewMapper.sentGetTotalCount(userId);
    }
}
