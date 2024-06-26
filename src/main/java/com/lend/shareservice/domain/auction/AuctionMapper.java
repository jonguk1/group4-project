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

    List<AuctionDTO> findByAuctionList(Map<String, Object> map);

    List<AuctionDTO> findByCompleteAuctionList(Map<String, Object> map);

    Auction selectAuctionByBoardId(Integer boardId);

    void insertAuction(Auction auction);

    Auction selectAuctionId(Auction auction);

    int insertAuctionParticipant(Participant_Auction participantAuction);

    Auction selectMaxPrice(Auction auction);

    int selectIsAuctionById(Map<String, Object> map);

    int selectParticipantCnt(Auction findAuctionId);

    List<String> selectIdsByAuctionId(Integer auctionId);

    int updateCurrentPrice(Map<String, Object> map);

    int getMaxPrice(int auctionId);

    int updateIsAuction(int auctionId);

    int getCurrentPrice(int auctionId);

    List<AuctionDTO> getDeadlineList();

    Date getDeadline(int auctionId);

    String findByAuctionUserId(String userId,int auctionId);

    int findByMoney(String userId);

    Integer selectBoardId(int auctionId);

    void auctionCancel(Auction auction);

    void updateBeforeIsAuction(Auction auction);

    int deleteParticipant(Participant_Auction auction);

    void deleteAuction(Auction auction);

    void lockParticipant(Participant_Auction auction);

    void lockAuction(int auctionId);
}
