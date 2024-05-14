package com.lend.shareservice.web.chat.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
@Data
@Getter
@Setter
public class ReservDTO {
    // 예약날짜
    private Date ReservationDate;
    // 채팅방번호 (ID)
    private Integer chatId;
}
