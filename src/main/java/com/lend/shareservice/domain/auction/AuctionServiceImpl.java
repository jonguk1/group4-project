package com.lend.shareservice.domain.auction;


import com.lend.shareservice.domain.notification.EmitterRepository;
import com.lend.shareservice.web.auction.dto.AuctionDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.entity.Auction;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AuctionServiceImpl implements AuctionService{

    private final AuctionMapper auctionMapper;

    @Override
    public int getAuctionCount(String userId) {
        return auctionMapper.getAuctionCount(userId);
    }

    @Override
    public List<AuctionDTO> auctions(PagingDTO page, String userId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return auctionMapper.auctions(map);
    }


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
