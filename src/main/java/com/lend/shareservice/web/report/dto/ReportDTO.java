package com.lend.shareservice.web.report.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.lend.shareservice.entity.Board;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
public class ReportDTO {
    private String userId;
    private String title;
    private String content;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime regDate;

    private int writerCnt;
    private List<Board> boards;
}
