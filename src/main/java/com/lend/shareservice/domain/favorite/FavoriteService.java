package com.lend.shareservice.domain.favorite;

import com.lend.shareservice.entity.Favorite;

import java.util.List;

public interface FavoriteService {

    List<Favorite> favorites(int limit,int offset,String userId);

    int getFavoriteTotalCount();


}
