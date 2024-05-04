package com.lend.shareservice.domain.favorite;

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
    public List<FavoriteDTO> favorites(PagingDTO page, String userId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("limit", page.getLimit());
        map.put("offset", page.getOffset());
        return favoriteMapper.favorites(map);
    }

    @Override
    public int getFavoriteTotalCount(PagingDTO page) {
        return favoriteMapper.getFavoriteTotalCount(page);
    }

}
