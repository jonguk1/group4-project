package com.lend.shareservice.entity;

import lombok.Data;

import jakarta.validation.constraints.NotNull;

// 차단
@Data
public class Block {

    // 차단 번호 (Id)
    @NotNull
    private Integer blockId;

    // 차단한 사람 (FK)
    @NotNull
    private String blockUserId;

    // 차단당한 사람 (FK)
    @NotNull
    private String blockedUserId;

}
