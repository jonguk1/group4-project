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

     List<PostDTO> findInterestPosts();

    List<PostDTO> sortForHits(List<PostDTO> postDTOS);

    List<PostDTO> sortForInterest(List<PostDTO> postDTOS);

    List<PostDTO> sortForLowPrice(List<PostDTO> postDTOS) throws ParseException;

    boolean registerInterestPost(String userId, Integer boardId);

    boolean deleteInterestPost(String userId, Integer boardId);


}
