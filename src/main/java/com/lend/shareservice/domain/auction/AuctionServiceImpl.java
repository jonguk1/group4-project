package com.lend.shareservice.domain.auction;


import com.lend.shareservice.entity.Auction;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuctionServiceImpl implements AuctionService{

    private final AuctionMapper auctionMapper;


    @Override
    public void paticipateAuction(String id, Integer boardId) {

        Auction findAuction = auctionMapper.selectAuctionByBoardId(boardId);

        // 아직 생성된 적 없음 -> 생성
        if (findAuction == null) {
            Auction auction = new Auction();
            auction.setBoardId(boardId);
            auction.setCurrentPrice(0);
            auctionMapper.insertAuction(auction);
        } else {

        }
    }
}
