package com.lend.shareservice.web.block;

import com.lend.shareservice.domain.block.BlockService;
import com.lend.shareservice.domain.user.UserService;
import com.lend.shareservice.entity.Block;
import com.lend.shareservice.entity.User;
import com.lend.shareservice.web.block.dto.BlockDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class BlockController {

    private final BlockService blockService;

    @GetMapping("/user/{userId}/block")
    public String blockUserList(Model model,
                                @PathVariable("userId") String userId,
                                PagingDTO page,
                                @RequestParam(defaultValue = "1") int pageNum){
        int totalCount=blockService.getBlockCount(userId);

        page.setTotalCount(totalCount);
        page.setOneRecordPage(6);
        page.setPagingBlock(5);

        page.init();

        List<BlockDTO> blocks = blockService.findByBlockList(page,userId);
        String loc ="/user/"+userId+"/block";

        String pageNavi=page.getPageNavi(loc);

        model.addAttribute("blocks",blocks);
        model.addAttribute("page",page);
        model.addAttribute("pageNavi",pageNavi);

        return "jspp/myBlock";
    }

    @DeleteMapping("/block/{blockedUserId}")
    public ResponseEntity<String> deleteBlockUser(@PathVariable("blockedUserId") String blockedUserId,Model model){
        int n = blockService.deleteBlock(blockedUserId);
        if (n > 0) {
            return ResponseEntity.ok("ok");
        } else {
            return ResponseEntity.ok("no");
        }
    }
}
