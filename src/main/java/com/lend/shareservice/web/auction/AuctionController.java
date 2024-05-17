package com.lend.shareservice.web.auction;

import com.lend.shareservice.domain.auction.AuctionService;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.format.DateTimeFormatter;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AuctionController {

    private final AuctionService auctionService;
    private final UserService userService;


    @GetMapping(value = "/time/{user_id}", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @ResponseBody
    public SseEmitter serverTime() {
        SseEmitter emitter = new SseEmitter();

        // 시간 데이터를 비동기적으로 보내기 위한 쓰레드 생성
        Thread thread = new Thread(() -> {
            try {
                while (true) {
                    String isoTimeString = Instant.now().toString(); // 현재 시간을 ISO 8601 형식의 문자열로 변환
                    emitter.send(isoTimeString);
                    Thread.sleep(1000); // 1초마다 보냄
                }
            } catch (Exception e) {
                emitter.completeWithError(e); // 에러가 발생하면 에러를 보냄
            }
        });
        thread.start();

        return emitter;
    }

    @GetMapping("/auction/{user_id}")
    public String myAuctionList(Model model,
                                PagingDTO page,
                                @PathVariable("user_id") String userId,
                                @RequestParam(defaultValue = "1") int pageNum){

        userId=userService.getUserId(userId);

        int totalCount = auctionService.getAuctionCount(userId);
        page.setTotalCount(totalCount);
        page.setOneRecordPage(3);
        page.setPagingBlock(5);

        page.init();

        List<AuctionDTO> auctions = auctionService.auctions(page,userId);

        String loc ="/auction/"+userId;

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("auctions",auctions);
        model.addAttribute("userId",userId);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);

        return "jspp/myAuction";
    }

    @PostMapping("/auction/{auction_id}/current-price")
    public ResponseEntity<String> updateCurrentPrice(@PathVariable("auction_id") int auctionId,
                                                     @RequestParam(value = "currentPrice", defaultValue = "0") int currentPrice) {
        String loginUser = "테스트1";

        try {
            loginUser = URLEncoder.encode(loginUser, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        if (currentPrice == 0) {
            return ResponseEntity.ok("emptyCurrentPrice");
        }

        int maxPrice= auctionService.getMaxPrice(auctionId);

        if(currentPrice>maxPrice){
            return ResponseEntity.ok("maxCurrentPrice");
        }

        int n = auctionService.updateCurrentPrice(auctionId, currentPrice);

        if (n > 0) {
            return ResponseEntity.ok("ok");
        } else {
            return ResponseEntity.ok("no");
        }
    }

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
