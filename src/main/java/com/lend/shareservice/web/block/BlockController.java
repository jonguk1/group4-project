package com.lend.shareservice.web.block;

import com.lend.shareservice.domain.block.BlockService;
import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.entity.Block;
import com.lend.shareservice.entity.User;
import com.lend.shareservice.web.block.dto.BlockDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class BlockController {

    private final UserService userService;

    private final BlockService blockService;

    @GetMapping("/user/{user_id}/block")
    public String blockUserList(Model model,
                                @PathVariable("user_id") String userId,
                                PagingDTO page,
                                @RequestParam(defaultValue = "1") int pageNum){

        userId=userService.getUserId(userId);

        int totalCount=blockService.getBlockCount(userId);

        page.setTotalCount(totalCount);
        page.setOneRecordPage(6);
        page.setPagingBlock(5);

        page.init();

        List<BlockDTO> blocks=blockService.blocks(page,userId);
        String loc ="/user/"+userId+"/block";

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("blocks",blocks);
        model.addAttribute("userId",userId);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);

        return "jspp/myBlock";
    }


    @GetMapping("/user/{blocked_user_id}")
    public String deleteBlockUser(@PathVariable("blocked_user_id") String userId,Model model){

        String loginUser="테스트1";

        try {
            loginUser = URLEncoder.encode(loginUser, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        if(userId==null||userId.equals("")){
            return "redirect:/user/"+loginUser+"/block";
        }

        int n = blockService.deleteBlock(userId);

        return (n>0)?"redirect:/user/"+loginUser+"/block":"javascript:history.back()";
    }

}
