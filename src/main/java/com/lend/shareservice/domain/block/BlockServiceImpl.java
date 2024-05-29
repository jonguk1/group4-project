package com.lend.shareservice.domain.block;

import com.lend.shareservice.entity.Block;
import com.lend.shareservice.web.block.dto.BlockDTO;
import com.lend.shareservice.web.board.dto.PostDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class BlockServiceImpl implements BlockService{

    private final BlockMapper blockMapper;


    @Override
    public int getBlockCount(String userId) {
        return blockMapper.getBlockCount(userId);
    }

    @Override
    public List<BlockDTO> findByBlockList(PagingDTO page, String userId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return blockMapper.findByBlockList(map);
    }

    @Override
    public int deleteBlock(String userId) {
        return blockMapper.deleteBlock(userId);
    }

    // 차단된 유저가 쓴 글 제외
    @Override
    public  List<PostDTO> findNonBlockedPosts(List<PostDTO> posts, String userId) {

        List<String> blockedIds = blockMapper.selectAllBlokedIds(userId);

        Set<String> idSet = new HashSet<>(blockedIds);

        posts.removeIf(post -> idSet.contains(post.getWriter()));

        return posts;
    }
}
