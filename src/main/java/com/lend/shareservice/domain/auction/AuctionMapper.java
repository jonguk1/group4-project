package com.lend.shareservice.domain.auction;



import com.lend.shareservice.entity.Auction;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AuctionMapper {


    Auction selectAuctionByBoardId(Integer boardId);

    void insertAuction(Auction auction);
}
