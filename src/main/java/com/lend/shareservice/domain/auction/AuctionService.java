package com.lend.shareservice.domain.auction;


import com.lend.shareservice.web.auction.dto.AuctionDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.Date;
import java.util.List;

@Service
public interface AuctionService {

    int getAuctionCount(String userId);

    List<AuctionDTO> auctions(PagingDTO page,String userId);

    int paticipateAuction(String id, Integer boardId);

    boolean findCurrentAuctionState(String userId);
}
