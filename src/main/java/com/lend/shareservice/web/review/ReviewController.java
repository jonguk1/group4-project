package com.lend.shareservice.web.review;

import com.lend.shareservice.domain.review.ReviewService;
import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.entity.Favorite;
import com.lend.shareservice.entity.Review;
import com.lend.shareservice.web.favorite.dto.FavoriteDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import com.lend.shareservice.web.review.dto.ReviewDTO;
import com.lend.shareservice.web.review.dto.ReviewRegDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ReviewController {

    private final ReviewService reviewService;

    //받은 리뷰 목룩 보여주기
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

        List<ReviewDTO> receiveds=reviewService.findByReceivedList(page,userId);

        String loc ="/review/"+userId+"/received";

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("receiveds",receiveds);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);

        return "jspp/myReceivedReview";
    }

    //보낸 리뷰 목룩 보여주기
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

        List<ReviewDTO> sents=reviewService.findBySentList(page,userId);

        String loc ="/review/"+userId+"/sent";

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("sents",sents);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);

        return "jspp/mySentReview";
    }

    // 리뷰 등록 요청
    @PostMapping("/review")
    public ResponseEntity<?> registerReview(@Valid  @RequestBody ReviewRegDTO reviewRegDTO, BindingResult bindingResult) {

        log.info("reviewRegDTO = {}", reviewRegDTO);
        if (bindingResult.hasErrors()) {
            log.info("bindingResult = {}", bindingResult);
            Map<String, String> errors = new HashMap<>();
            for (FieldError error : bindingResult.getFieldErrors()) {
                errors.put(error.getField(), error.getDefaultMessage());
            }
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
        }

        if (reviewService.registerReview(reviewRegDTO) > 0) {
            return ResponseEntity.ok("ok");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
        }

    }
}
