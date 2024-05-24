package com.lend.shareservice.web.report.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class ReportRegDTO {

    @NotEmpty(message = "제목을 작성해주세요")
    @Size(max = 100, message = "제목 100자 초과")
    String title;

    @NotEmpty(message = "내용을 작성해주세요")
    @Size(max = 100, message = "글 내용 100자 초과")
    String content;

    @NotNull
    String writer;

    @NotNull
    Integer boardId;

}
