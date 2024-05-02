package com.lend.shareservice.domain.favorite;

import com.lend.shareservice.entity.Favorite;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface FavoriteMapper {
    List<Favorite> favorites(Map<String, Object> map);

    int getFavoriteTotalCount();

}
