package com.lend.shareservice.domain.board;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.web.board.dto.ItemAndBoardCategoryDTO;
import com.lend.shareservice.web.board.dto.ItemCategoryDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    void insertBoard(Board board);

    List<ItemCategoryDTO> selectAllItemCategory();

    List<Board> selectAllPostsByCategorys(ItemAndBoardCategoryDTO itemAndBoardCategoryDTO);

    Board selectPostById(Integer boardId);
}
