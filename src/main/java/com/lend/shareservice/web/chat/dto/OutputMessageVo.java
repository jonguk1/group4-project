package com.lend.shareservice.web.chat.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OutputMessageVo {

    private String sender;
    private String target;
    private String content;
    private String time;
}
