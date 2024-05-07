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

    List<PostDTO> findPostsBySearchTerm(String searchTerm);

    void incrementingViewCount(Integer boarId);

     List<PostDTO> findHitPosts();

    List<PostDTO> sortForHits(List<PostDTO> postDTOS);

    List<PostDTO> sortForInterest(List<PostDTO> postDTOS);

    List<PostDTO> sortForLowPrice(List<PostDTO> postDTOS) throws ParseException;
}
