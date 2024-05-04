package com.lend.shareservice.domain.review;

import com.lend.shareservice.entity.Review;
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
    public List<Review> receiveds(int limit, int offset, String userId) {
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userId);
        map.put("limit", limit);
        map.put("offset", offset);
        return reviewMapper.receiveds(map);
    }

    @Override
    public List<Review> sents(int limit, int offset, String userId) {
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userId);
        map.put("limit", limit);
        map.put("offset", offset);
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
