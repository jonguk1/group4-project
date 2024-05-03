package com.lend.shareservice.domain.board;

import com.lend.shareservice.entity.Board;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {

    void insertBoard(Board board);
}
