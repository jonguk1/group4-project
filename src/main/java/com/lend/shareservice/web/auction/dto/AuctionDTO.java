package com.lend.shareservice.web.auction.dto;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.entity.Participant_Auction;
import lombok.Data;

import java.util.List;

@Data
public class AuctionDTO {

    private Integer auctionId;
    private Integer currentPrice;
    private Integer maxPrice;
    private String userId;
    private int dateDifference;
    private List<Participant_Auction> participantAuctions;
    private List<AuctionBoardDTO> boards;
}
