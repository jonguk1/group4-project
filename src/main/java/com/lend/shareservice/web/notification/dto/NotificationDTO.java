package com.lend.shareservice.web.notification.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@AllArgsConstructor
public class NotificationDTO {

    private Integer notiId;
    private String userId;
    private String content;
    private String notiRegDate;

    // FK
    private Integer boardId;

}
