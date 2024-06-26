package com.lend.shareservice.web.board.interceptor;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lend.shareservice.domain.block.BlockMapper;
import com.lend.shareservice.domain.block.BlockService;
import com.lend.shareservice.domain.block.BlockServiceImpl;
import com.lend.shareservice.web.board.dto.PostDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
public class BlockedUserInterceptor implements HandlerInterceptor {

    private final BlockService blockService;

    // 차단 유저 글 비활성화
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {

        String allPostsByCategorysJson = (String) modelAndView.getModel().get("allPostsByCategorys");
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (allPostsByCategorysJson != null && userId != null) {
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
            try {
                List<PostDTO> posts = objectMapper.readValue(allPostsByCategorysJson, new TypeReference<List<PostDTO>>(){});
                List<PostDTO> nonBlockedPosts = blockService.findNonBlockedPosts(posts, userId);
                String nonBlockedPostsJSON = objectMapper.writeValueAsString(nonBlockedPosts);

                modelAndView.addObject("allPostsByCategorys", nonBlockedPostsJSON);
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }
}
