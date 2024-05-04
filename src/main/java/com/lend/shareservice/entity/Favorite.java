package com.lend.shareservice.entity;

import lombok.Data;

import jakarta.validation.constraints.NotNull;

import java.util.List;

// 채팅방
@Data
public class Favorite {

    // 관심번호 (ID)
    @NotNull
    private Integer favoriteId;

    // 유저 아이디 (FK)
    @NotNull
    private String userId;

    // 글번호 (FK)
    @NotNull
    private Integer boardId;

    private List<Board> boards;
}
