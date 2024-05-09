package com.lend.shareservice.domain.favorite;

import com.lend.shareservice.web.favorite.dto.FavoriteDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;

import java.util.List;

public interface FavoriteService {

    List<FavoriteDTO> favorites(PagingDTO page, String userId);

    int getFavoriteTotalCount(PagingDTO page);


    boolean findFavoriteByBoardIdAndUserId(String userId, Integer boardId);
}
