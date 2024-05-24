package com.lend.shareservice.domain.board;

import com.lend.shareservice.domain.board.dto.BoardAuctionStateDTO;
import com.lend.shareservice.entity.Board;
import com.lend.shareservice.entity.Favorite;
import com.lend.shareservice.web.board.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    void insertBoard(Board board);

    List<ItemCategoryDTO> selectAllItemCategory();

    List<Board> selectAllPostsByCategorys(ItemAndBoardCategoryDTO itemAndBoardCategoryDTO);

    Board selectPostById(Integer boardId);

    List<Board> selectPostsBySearchTerm(String searchTerm);

    int incrementingViewCount(Integer boardId);

    List<Board> selectAllPostsInOrderOfInterest();

    int insertFavorite(Favorite favorite);

    int deleteFavorite(Favorite favorite);

    int incrementInterest(Favorite favorite);

    int decreaseInterest(Favorite favorite);

    int getInterestCnt(Favorite favorite);

    int updateIsAuction(BoardAuctionStateDTO boardAuctionStateDTO);

    int updatePost(PostEditDTO postEditDTO);

    String selectImage1(Integer boardId);
    String selectImage2(Integer boardId);
    String selectImage3(Integer boardId);

    LatiLongDTO selectLatAndLong(Integer boardId);

    void expireMegaphone();
}
