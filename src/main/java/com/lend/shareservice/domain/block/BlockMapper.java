package com.lend.shareservice.domain.block;

import com.lend.shareservice.entity.Block;
import com.lend.shareservice.web.block.dto.BlockDTO;
import com.lend.shareservice.web.board.dto.PostDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface BlockMapper {

    int getBlockCount(String userId);

    List<BlockDTO> findByBlockList(Map<String, Object> map);

    int deleteBlock(String userId);



    List<String> selectAllBlokedIds(String userId);
}
