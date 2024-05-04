package com.lend.shareservice.web.review;

import com.lend.shareservice.domain.review.ReviewService;
import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.entity.Favorite;
import com.lend.shareservice.entity.Review;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    private final UserService userService;


    @GetMapping("/review/{userid}/received")
    public String receivedReviewList(Model model, @PathVariable("userid") String userId,
                                     @RequestParam(defaultValue = "1") int pageNum){

        userId=userService.getUserId(userId);

        if(pageNum<1){
            pageNum=1;
        }

        int totalCount=reviewService.receivedGetTotalCount(userId);
        int oneRecordPage=4;
        int pageCount= (totalCount-1)/oneRecordPage+1;
        if(pageNum>pageCount) {
            pageNum = pageCount;
        }

        int pagingBlock=5;
        int prevBlock = (pageNum-1)/pagingBlock*pagingBlock;
        int nextBlock = prevBlock + (pagingBlock + 1);

        int offset=(pageNum-1) * oneRecordPage;
        int limit= oneRecordPage;

        List<Review> receiveds=reviewService.receiveds(limit,offset,userId);

        model.addAttribute("receiveds",receiveds);
        model.addAttribute("totalCount",totalCount);
        model.addAttribute("pageCount",pageCount);
        model.addAttribute("userId",userId);
        model.addAttribute("oneRecordPage",oneRecordPage);
        model.addAttribute("prevBlock",prevBlock);
        model.addAttribute("nextBlock",nextBlock);
        model.addAttribute("pagingBlock",pagingBlock);

        return "jspp/myReceivedReview";
    }

    @GetMapping("/review/{userid}/sent")
    public String sentReviewList(Model model, @PathVariable("userid") String userId,
                                     @RequestParam(defaultValue = "1") int pageNum){

        userId=userService.getUserId(userId);

        if(pageNum<1){
            pageNum=1;
        }

        int totalCount=reviewService.sentGetTotalCount(userId);
        int oneRecordPage=4;
        int pageCount= (totalCount-1)/oneRecordPage+1;
        if(pageNum>pageCount) {
            pageNum = pageCount;
        }

        int pagingBlock=5;
        int prevBlock = (pageNum-1)/pagingBlock*pagingBlock;
        int nextBlock = prevBlock + (pagingBlock + 1);

        int offset=(pageNum-1) * oneRecordPage;
        int limit= oneRecordPage;

        List<Review> sents=reviewService.sents(limit,offset,userId);

        model.addAttribute("sents",sents);
        model.addAttribute("totalCount",totalCount);
        model.addAttribute("pageCount",pageCount);
        model.addAttribute("userId",userId);
        model.addAttribute("oneRecordPage",oneRecordPage);
        model.addAttribute("prevBlock",prevBlock);
        model.addAttribute("nextBlock",nextBlock);
        model.addAttribute("pagingBlock",pagingBlock);

        return "jspp/mySentReview";
    }
}
