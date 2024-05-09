package com.lend.shareservice.web.auction;

import com.lend.shareservice.domain.auction.AuctionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequiredArgsConstructor
public class AuctionController {

    private final AuctionService auctionService;

    @PostMapping("/auction/{boardId}")
    public String auction(@PathVariable("boardId") Integer boardId) {
        String id = "hong";

        auctionService.paticipateAuction(id, boardId);
        return "";
    }

}
