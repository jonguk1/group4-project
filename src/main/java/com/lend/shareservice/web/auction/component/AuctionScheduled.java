package com.lend.shareservice.web.auction.component;


import com.lend.shareservice.domain.auction.AuctionService;
import com.lend.shareservice.web.auction.dto.AuctionBoardDTO;
import com.lend.shareservice.web.auction.dto.AuctionDTO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.List;

@Component
@RequiredArgsConstructor
public class AuctionScheduled {

    private final AuctionService auctionService;

    @Scheduled(fixedRate = 10000)
    public void checkDeadLine(){

        List<AuctionDTO> auctionBoardDTOList = auctionService.getDeadlineList();

        Instant currentInstant = Instant.now();

        for (AuctionDTO auctionDTO : auctionBoardDTOList) {
            for (AuctionBoardDTO board : auctionDTO.getBoards()) {
                if (board.getDeadline().toInstant().isBefore(currentInstant)) {
                    auctionService.updateIsAuction(auctionDTO.getAuctionId());
                }
            }
        }
    }

}
