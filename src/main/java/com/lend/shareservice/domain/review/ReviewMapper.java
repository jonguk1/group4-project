package com.lend.shareservice.domain.review;

import com.lend.shareservice.entity.Favorite;
import com.lend.shareservice.entity.Review;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.review.dto.ReviewDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReviewMapper {

    List<ReviewDTO> receiveds(Map<String, Object> map);

    public int receivedGetTotalCount(String userId);

    public List<ReviewDTO> sents(Map<String, Object> map);

    public int sentGetTotalCount(String userId);
}
