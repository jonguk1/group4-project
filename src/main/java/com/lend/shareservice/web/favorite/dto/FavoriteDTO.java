package com.lend.shareservice.web.favorite.dto;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.entity.Favorite;
import lombok.Data;

import java.util.List;

@Data
public class FavoriteDTO {

    private Integer favoriteId;
    private String userId;
    private Integer boardId;
    private List<Board> boards;
    private String address;
}
