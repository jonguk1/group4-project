package com.lend.shareservice.domain.favorite;

import com.lend.shareservice.entity.Favorite;
import com.lend.shareservice.web.favorite.dto.FavoriteDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class FavoriteServiceImpl implements FavoriteService{

    private final FavoriteMapper favoriteMapper;


    @Override
    public List<FavoriteDTO> findByFavoriteList(PagingDTO page, String userId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return favoriteMapper.findByFavoriteList(map);
    }

    @Override
    public int getFavoriteTotalCount(PagingDTO page) {
        return favoriteMapper.getFavoriteTotalCount(page);
    }

    @Override
    public boolean findFavoriteByBoardIdAndUserId(String userId, Integer boardId) {
        Favorite favorite = new Favorite();
        favorite.setUserId(userId);
        favorite.setBoardId(boardId);
        Favorite findFavorite = favoriteMapper.selectByBoardIdAndUserId(favorite);

        if (findFavorite == null) {
            return false;
        } else {
            return true;
        }
    }
}
