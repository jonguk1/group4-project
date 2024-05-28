package com.lend.shareservice.domain.block;

import com.lend.shareservice.entity.Block;
import com.lend.shareservice.web.block.dto.BlockDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
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


}
