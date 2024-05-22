package com.lend.shareservice.domain.auction;



import com.lend.shareservice.web.auction.dto.AuctionBoardDTO;
import com.lend.shareservice.web.auction.dto.AuctionDTO;
import com.lend.shareservice.entity.Auction;
import com.lend.shareservice.entity.Participant_Auction;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Mapper
public interface AuctionMapper {

    int getAuctionCount(String userId);

    int getCompleteAuctionCount(String userId);

    List<AuctionDTO> auctions(Map<String, Object> map);

    List<AuctionDTO> completeAuctions(Map<String, Object> map);

    Auction selectAuctionByBoardId(Integer boardId);

    void insertAuction(Auction auction);

    Auction selectAuctionId(Auction auction);

    int insertAuctionParticipant(Participant_Auction participantAuction);

    Auction selectMaxPrice(Auction auction);

    int selectIsAuctionById(String userId);

    int selectParticipantCnt(Auction findAuctionId);

    List<String> selectIdsByAuctionId(Integer auctionId);

    int updateCurrentPrice(Map<String, Object> map);

    int getMaxPrice(int auctionId);

    int updateIsAuction(int auctionId);

    int getCurrentPrice(int auctionId);

    List<AuctionDTO> getDeadlineList();

    Date getDeadline(int auctionId);
}
