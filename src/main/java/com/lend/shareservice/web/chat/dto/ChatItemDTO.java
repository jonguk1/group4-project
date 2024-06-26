package com.lend.shareservice.web.chat.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class ChatItemDTO {
    private Integer boardId;
    private String writer;
    private String title;
    private String images;
    private String lendState;
}
