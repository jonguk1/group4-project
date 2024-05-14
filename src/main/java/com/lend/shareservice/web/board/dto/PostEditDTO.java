package com.lend.shareservice.web.board.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.constraints.*;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Data
public class PostEditDTO {

    private Integer boardCategoryId;
    private Integer boardId;
    @NotBlank(message = "글 제목을 입력해주세요")
    @Size(max = 100, message = "글 제목 100자 초과")
    private String title;

    @NotBlank(message = "상품명을 입력해주세요")
    @Size(max = 100, message = "상품명 30자 초과")
    private String itemName;

    @NotBlank(message = "가격을 입력해주세요")
    private String price;

    private Integer itemCategoryId;
    private List<MultipartFile> fileInput;

    @NotBlank(message = "글 내용을 입력해주세요")
    @Size(max = 3000, message = "글 내용 3000자 초과")
    private String content;

    private Double latitude;
    private Double longitude;
    private LocalDate returnDate;

}
