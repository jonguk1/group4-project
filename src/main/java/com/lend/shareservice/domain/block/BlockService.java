package com.lend.shareservice.domain.block;

import com.lend.shareservice.entity.Block;
import com.lend.shareservice.web.block.dto.BlockDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface BlockService {

    int getBlockCount(String userId);

    List<BlockDTO> blocks(PagingDTO page, String userId);

    int deleteBlock(String userId);
}
