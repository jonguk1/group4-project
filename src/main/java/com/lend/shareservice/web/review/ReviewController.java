package com.lend.shareservice.web.review;

import com.lend.shareservice.domain.review.ReviewService;
import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.entity.Favorite;
import com.lend.shareservice.entity.Review;
import com.lend.shareservice.web.favorite.dto.FavoriteDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.review.dto.ReviewDTO;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;


    @GetMapping("/review/{userId}/received")
    public String receivedReviewList(Model model,
                                     PagingDTO page,
                                     @PathVariable("userId") String userId,
                                     @RequestParam(defaultValue = "1") int pageNum){
        int totalCount= reviewService.receivedGetTotalCount(userId);

        page.setTotalCount(totalCount);
        page.setOneRecordPage(6);
        page.setPagingBlock(5);

        page.init();

        List<ReviewDTO> receiveds=reviewService.receiveds(page,userId);

        String loc ="/review/"+userId+"/received";

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("receiveds",receiveds);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);

        return "jspp/myReceivedReview";
    }

    @GetMapping("/review/{userId}/sent")
    public String sentReviewList(Model model,
                                 PagingDTO page,
                                 @PathVariable("userId") String userId,
                                     @RequestParam(defaultValue = "1") int pageNum){

        int totalCount=reviewService.sentGetTotalCount(userId);

        page.setTotalCount(totalCount);
        page.setOneRecordPage(6);
        page.setPagingBlock(5);

        page.init();

        List<ReviewDTO> sents=reviewService.sents(page,userId);

        String loc ="/review/"+userId+"/sent";

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("sents",sents);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);

        return "jspp/mySentReview";
    }
}
