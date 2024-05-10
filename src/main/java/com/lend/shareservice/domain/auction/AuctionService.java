package com.lend.shareservice.domain.auction;


import com.lend.shareservice.web.auction.dto.AuctionDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public interface AuctionService {

    int getAuctionCount(String userId);

    List<AuctionDTO> auctions(PagingDTO page,String userId);

    // 경매 마감일로부터 현재 날짜까지의 일수 차이 계산
    long calculateDaysUntilDeadline(Date deadline);

}
