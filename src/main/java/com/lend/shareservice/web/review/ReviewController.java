package com.lend.shareservice.web.review;

import com.lend.shareservice.domain.review.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;
}
