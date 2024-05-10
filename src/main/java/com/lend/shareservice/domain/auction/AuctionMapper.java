package com.lend.shareservice.domain.auction;



import com.lend.shareservice.web.auction.dto.AuctionDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AuctionMapper {

    int getAuctionCount(String userId);

    List<AuctionDTO> auctions(Map<String, Object> map);

}
