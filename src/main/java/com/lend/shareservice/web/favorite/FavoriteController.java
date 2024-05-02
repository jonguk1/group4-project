package com.lend.shareservice.web.favorite;

import com.lend.shareservice.domain.favorite.FavoriteService;
import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.entity.Favorite;
import com.lend.shareservice.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class FavoriteController {

    private final FavoriteService favoriteService;

    private final UserService userService;

    @GetMapping("/favorite/{userid}")
    public String favoriteView(Model model, @PathVariable("userid") String userId,
                               @RequestParam(defaultValue = "1") int pageNum){

        System.out.println(userId);
        userId=userService.getUserId(userId);

        if(pageNum<1){
            pageNum=1;
        }
        int totalCount=favoriteService.getFavoriteTotalCount();
        System.out.println(totalCount);
        int oneRecordPage=4;
        int pageCount= (totalCount-1)/oneRecordPage+1;
        if(pageNum>pageCount) {
            pageNum = pageCount;
        }

        int pagingBlock=4;
        int prevBlock = (pageNum-1)/pagingBlock*pagingBlock;
        int nextBlock = prevBlock + (pagingBlock + 1);

        int offset=(pageNum-1) * oneRecordPage;
        int limit= oneRecordPage;

        List<Favorite> favorites=favoriteService.favorites(limit,offset,userId);

        System.out.println(favorites.size());

        model.addAttribute("favorites",favorites);
        model.addAttribute("totalCount",totalCount);
        model.addAttribute("pageCount",pageCount);
        model.addAttribute("userId",userId);
        model.addAttribute("oneRecordPage",oneRecordPage);

        model.addAttribute("prevBlock",prevBlock);
        model.addAttribute("nextBlock",nextBlock);
        model.addAttribute("pagingBlock",pagingBlock);

        return "jspp/myInterest";
    }
}
