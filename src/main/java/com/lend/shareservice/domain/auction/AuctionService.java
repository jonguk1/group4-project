package com.lend.shareservice.domain.auction;



public interface AuctionService {


    int paticipateAuction(String id, Integer boardId);

    boolean findCurrentAuctionState(String userId);
}
