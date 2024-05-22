package com.lend.shareservice.domain.board.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BoardAuctionStateDTO {

    Integer boardId;
    String state;
}
