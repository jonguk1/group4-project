package com.lend.shareservice.web.auction;

import com.lend.shareservice.domain.auction.AuctionService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AuctionController {

    private final AuctionService auctionService;

    @PostMapping("/auction/{boardId}")
    public ResponseEntity<String> auction(@PathVariable("boardId") Integer boardId) {
        String id = "hong";

        if (auctionService.paticipateAuction(id, boardId) > 0) {
            return ResponseEntity.ok("ok");
        }
        return ResponseEntity.ok("no");
    }

    @GetMapping("/auction/is/{userId}")
    public ResponseEntity<String> currentAuctionState(@PathVariable("userId") String userId) {

        boolean isAuction = auctionService.findCurrentAuctionState(userId);

        if (isAuction) {
            return ResponseEntity.ok("ok");
        } else {
            return ResponseEntity.ok("no");
        }
    }

}
