package com.lend.shareservice.domain.auction;



import com.lend.shareservice.web.auction.dto.AuctionDTO;
import com.lend.shareservice.entity.Auction;
import com.lend.shareservice.entity.Participant_Auction;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
<<<<<<< HEAD
import java.util.Map;
=======
>>>>>>> develop

@Mapper
public interface AuctionMapper {

    int getAuctionCount(String userId);

    List<AuctionDTO> auctions(Map<String, Object> map);

    Auction selectAuctionByBoardId(Integer boardId);

    void insertAuction(Auction auction);

    Auction selectAuctionId(Auction auction);

    int insertAuctionParticipant(Participant_Auction participantAuction);

    Auction selectMaxPrice(Auction auction);

    int selectIsAuctionById(String userId);

    int selectParticipantCnt(Auction findAuctionId);

    List<String> selectIdsByAuctionId(Integer auctionId);
}
