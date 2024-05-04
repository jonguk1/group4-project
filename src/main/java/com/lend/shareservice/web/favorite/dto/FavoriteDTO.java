package com.lend.shareservice.web.favorite.dto;

import com.lend.shareservice.entity.Board;
import com.lend.shareservice.entity.Favorite;
import lombok.Data;

import java.util.List;

@Data
public class FavoriteDTO {

    private Integer favorite_id;
    private String user_id;
    private Integer board_id;
    private List<Board> boards;
}
