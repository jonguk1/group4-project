package com.lend.shareservice.domain.board;

import com.lend.shareservice.web.board.dto.*;

import java.text.ParseException;
import java.util.List;

public interface BoardService {

    // 글 저장
    void savePost(PostRegistrationDTO postRegistrationDTO) throws ParseException;

    List<ItemCategoryDTO> findAllItemCategory();

    List<PostDTO> findAllPostsByCategorys(ItemAndBoardCategoryDTO itemAndBoardCategoryDTO);

    ItemDetailDTO findPostById(Integer board_id);
}
