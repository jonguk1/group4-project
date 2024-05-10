package com.lend.shareservice.domain.block;

import com.lend.shareservice.entity.Block;
import com.lend.shareservice.web.block.dto.BlockDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface BlockMapper {

    int getBlockCount(String userId);

    List<BlockDTO> blocks(Map<String, Object> map);

    int deleteBlock(String userId);
}
