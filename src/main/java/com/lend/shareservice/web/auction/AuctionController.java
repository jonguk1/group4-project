package com.lend.shareservice.web.auction;

import com.lend.shareservice.domain.auction.AuctionService;
import com.lend.shareservice.domain.auction.AuctionState;
import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.entity.Board;
import com.lend.shareservice.web.auction.dto.AuctionBoardDTO;
import com.lend.shareservice.web.auction.dto.AuctionDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.constraints.Future;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.format.DateTimeFormatter;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AuctionController {

    private final AuctionService auctionService;

    @GetMapping(value = "/time", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter getTime() {
        SseEmitter emitter = new SseEmitter();
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

        scheduler.scheduleAtFixedRate(() -> {
            try {
                emitter.send(Instant.now().toString());
            } catch (IOException e) {
                emitter.completeWithError(e);
            }
        }, 0, 1, TimeUnit.SECONDS);

        emitter.onCompletion(scheduler::shutdown);
        emitter.onTimeout(scheduler::shutdown);

        return emitter;
    }

    @GetMapping("/auction/{userId}")
    public String myAuctionList(Model model,
                                PagingDTO page,
                                @PathVariable("userId") String userId,
                                @RequestParam(defaultValue = "1") int pageNum){

        int totalCount = auctionService.getAuctionCount(userId);
        page.setTotalCount(totalCount);
        page.setOneRecordPage(3);
        page.setPagingBlock(5);

        page.init();

        List<AuctionDTO> auctions = auctionService.auctions(page,userId);

        String loc ="/auction/"+userId;

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("auctions",auctions);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);

        return "jspp/myAuction";
    }

    @GetMapping("/auction/{userId}/complete")
    public String myAuctionCompleteList(Model model,
                               PagingDTO page,
                               @PathVariable("userId") String userId,
                               @RequestParam(defaultValue = "1") int pageNum){

        int totalCount = auctionService.getCompleteAuctionCount(userId);
        page.setTotalCount(totalCount);
        page.setOneRecordPage(3);
        page.setPagingBlock(5);

        page.init();

        List<AuctionDTO> auctions = auctionService.completeAuctions(page,userId);

        String loc ="/auction/"+userId+"/complete";

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("auctions",auctions);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);

        return "jspp/myAuction";
    }

    @PutMapping("/auction/{auctionId}/current-price")
    public ResponseEntity<String> updateCurrentPrice(@PathVariable("auctionId") int auctionId,
                                                     @RequestParam(value = "currentPrice", defaultValue = "0") int currentPrice,
                                                     @RequestParam(value="userId") String userId) {
        String result = auctionService.updateCurrentPrice(auctionId, currentPrice, userId);
        return ResponseEntity.ok(result);
    }

    @PatchMapping("/auction/{auctionId}/isAuction")
    public ResponseEntity<String> updateIsAuction(@PathVariable("auctionId") int auctionId){
        if(auctionService.updateIsAuction(auctionId)>0){
            return ResponseEntity.ok("ok");
        }
        return ResponseEntity.ok("no");
    }

    // 경매 참여
    @PostMapping("/auction/{boardId}")
    public ResponseEntity<String> auction(HttpServletRequest request, @PathVariable("boardId") Integer boardId) {

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (auctionService.paticipateAuction(userId, boardId) > 0) {
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
