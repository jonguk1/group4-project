package com.lend.shareservice.domain.favorite;

import com.lend.shareservice.entity.Favorite;
import com.lend.shareservice.web.favorite.dto.FavoriteDTO;
import com.lend.shareservice.web.paging.dto.PagingDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface FavoriteMapper {
    List<FavoriteDTO> favorites(Map<String, Object> map);

    int getFavoriteTotalCount(PagingDTO page);

    Favorite selectByBoardIdAndUserId(Favorite favorite);
}
