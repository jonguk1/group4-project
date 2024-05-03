package com.lend.shareservice.domain.review;

import com.lend.shareservice.entity.Favorite;
import com.lend.shareservice.entity.Review;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReviewMapper {

    List<Review> receiveds(Map<String, Object> map);

    public int receivedGetTotalCount(String userId);

    public List<Review> sents(Map<String, Object> map);

    public int sentGetTotalCount(String userId);
}
