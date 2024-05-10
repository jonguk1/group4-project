package com.lend.shareservice.domain.chat;

import com.lend.shareservice.entity.Board;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatMapper {

    Board selectItem(Integer boardId);
}
