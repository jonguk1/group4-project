package com.lend.shareservice.web.report.dto;

import com.lend.shareservice.entity.Board;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.util.List;

@Data
@NoArgsConstructor
public class ReportDTO {
    private String userId;
    private String title;
    private String content;
    private Date regDate;
    private int writerCnt;
    private List<Board> boards;
}
