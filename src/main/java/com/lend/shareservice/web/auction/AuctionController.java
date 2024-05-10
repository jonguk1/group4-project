package com.lend.shareservice.web.auction;

import com.lend.shareservice.domain.auction.AuctionService;
import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.entity.Board;
import com.lend.shareservice.web.auction.dto.AuctionBoardDTO;
import com.lend.shareservice.web.auction.dto.AuctionDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import jakarta.validation.constraints.Future;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AuctionController {

    private final AuctionService auctionService;

    private final UserService userService;

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

        log.info("limit: "+page.getLimit());
        log.info("offset: "+page.getOffset());

        List<AuctionDTO> auctions = auctionService.auctions(page,userId);

        for (AuctionDTO auction : auctions) {
            List<AuctionBoardDTO> boards = auction.getBoards();
            for (AuctionBoardDTO board : boards) {
                Date deadline = board.getDeadline();
                long daysUntilDeadline= auctionService.calculateDaysUntilDeadline(deadline);
                auction.setDateDifference((int) daysUntilDeadline);
            }
        }

        String loc ="/auction/"+userId;

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("auctions",auctions);
        model.addAttribute("userId",userId);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);

        return "jspp/myAuction";
    }


}
