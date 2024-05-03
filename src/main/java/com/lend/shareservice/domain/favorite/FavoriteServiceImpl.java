package com.lend.shareservice.domain.favorite;

import com.lend.shareservice.entity.Favorite;
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
    public List<Favorite> favorites(int limit,int offset,String userId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("limit", limit);
        map.put("offset", offset);
        return favoriteMapper.favorites(map);
    }

    @Override
    public int getFavoriteTotalCount() {
        return favoriteMapper.getFavoriteTotalCount();
    }

}
