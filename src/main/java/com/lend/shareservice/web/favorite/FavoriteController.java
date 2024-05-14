package com.lend.shareservice.web.favorite;

import com.lend.shareservice.domain.favorite.FavoriteService;
import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.web.favorite.dto.FavoriteDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class FavoriteController {

    private final FavoriteService favoriteService;

    private final UserService userService;

    @GetMapping("/favorite/{userid}")
    public String favoriteView(Model model,
                               PagingDTO page,
                               @PathVariable("userid") String userId,
                               @RequestParam(defaultValue = "1") int pageNum){

        userId=userService.getUserId(userId);

        int totalCount= favoriteService.getFavoriteTotalCount(page);

        page.setTotalCount(totalCount);
        page.setOneRecordPage(6);
        page.setPagingBlock(5);

        page.init();

        List<FavoriteDTO> favorites=favoriteService.favorites(page,userId);

        String loc ="/favorite/"+userId;

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("favorites",favorites);
        model.addAttribute("userId",userId);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);

        return "jspp/myInterest";
    }


    // 유저 해당 글에 대한 관심 유무 체크
    @GetMapping("/favorite/is/{boardId}")
    public ResponseEntity<String> isFavorite(@PathVariable("boardId") Integer boardId) {

        String userId = "hong";
        boolean isFavorite = favoriteService.findFavoriteByBoardIdAndUserId(userId, boardId);

        if (isFavorite) {
            return ResponseEntity.ok("ok");
        } else {
            return ResponseEntity.ok("no");
        }
    }
}
