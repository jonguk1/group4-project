package com.lend.shareservice.domain.review;

import com.lend.shareservice.entity.Review;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.review.dto.ReviewDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReviewMapper {

    List<ReviewDTO> findByReceivedList(Map<String, Object> map);

    int receivedGetTotalCount(String userId);

    List<ReviewDTO> findBySentList(Map<String, Object> map);

    int sentGetTotalCount(String userId);
}
