package com.lend.shareservice.domain.auction;


import com.lend.shareservice.web.auction.dto.AuctionBoardDTO;
import com.lend.shareservice.web.auction.dto.AuctionDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.Date;
import java.util.List;

@Service
public interface AuctionService {

    int getAuctionCount(String userId);

    int getCompleteAuctionCount(String userId);

    List<AuctionDTO> findByAuctionList(PagingDTO page,String userId);

    List<AuctionDTO> findByCompleteAuctionList(PagingDTO page,String userId);

    String updateCurrentPrice(int auctionId,int currentPrice,String userId);

    int paticipateAuction(String id, Integer boardId);

    boolean findCurrentAuctionState(String userId, Integer boardId);

    int updateIsAuction(int auctionId);

    List<AuctionDTO> getDeadlineList();

    String auctionCancel(String userId,int auctionId);


}
