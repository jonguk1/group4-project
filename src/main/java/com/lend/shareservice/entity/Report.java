package com.lend.shareservice.entity;

import lombok.Data;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.sql.Date;

// 신고
@Data
public class Report {

    // 신고 번호 (ID)
    @NotNull
    private Integer reportId;

    // 글번호 (FK)
    @NotNull
    private Integer boardId;

    // 작성자 (FK)
    @NotNull
    private String userId;

    // 제목
    @NotNull
    @Size(max = 100, message = "글 제목 100자 초과")
    private String title;

    // 내용
    @NotBlank(message = "신고 내용을 입력하세요")
    @Size(max = 2000, message = "글 내용 2000자 초과")
    private String content;

    // 등록일 (default = sysdate)
    @NotNull
    private Date regDate;

    public Report(Integer boardId, String userId, String title, String content) {
        this.boardId = boardId;
        this.userId = userId;
        this.title = title;
        this.content = content;
    }
}
