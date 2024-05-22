package com.lend.shareservice.domain.board;

import com.lend.shareservice.domain.board.dto.BoardAuctionStateDTO;
import com.lend.shareservice.web.board.dto.*;

import java.text.ParseException;
import java.util.List;

public interface BoardService {

    // 글 저장
    void savePost(PostRegistrationDTO postRegistrationDTO) throws ParseException;

    List<ItemCategoryDTO> findAllItemCategory();

    List<PostDTO> findAllPostsByCategorys(String userId, ItemAndBoardCategoryDTO itemAndBoardCategoryDTO);

    ItemDetailDTO findPostById(Integer board_id);

    List<PostDTO> findPostsBySearchTerm(String userId, String searchTerm);

    int incrementingViewCount(Integer boarId);

     List<PostDTO> findInterestPosts(String userId);

    List<PostDTO> sortForHits(List<PostDTO> postDTOS);

    List<PostDTO> sortForInterest(List<PostDTO> postDTOS);

    List<PostDTO> sortForLowPrice(List<PostDTO> postDTOS) throws ParseException;

    int registerInterestPost(String userId, Integer boardId);

    int deleteInterestPost(String userId, Integer boardId);


    List<PostDTO> getPostsByTitleAndContent(List<PostDTO> postDTOS, String searchTermDetail);

    List<PostDTO> sortForRecent(List<PostDTO> postDTOS);

    List<PostDTO> sortForDistance(List<PostDTO> postDTOS);

    int calculateRoundedDistance(double lat1, double lon1, double lat2, double lon2);

    int updateIsAuction(BoardAuctionStateDTO boardAuctionStateDTO);

    int editPost(PostEditDTO postEditDTO);
}
