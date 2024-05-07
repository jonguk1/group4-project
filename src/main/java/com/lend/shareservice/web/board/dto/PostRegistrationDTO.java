package com.lend.shareservice.web.board.dto;

import jakarta.validation.constraints.*;
import lombok.Data;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Bool;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@Data
public class PostRegistrationDTO {

    private Integer boardCategoryId;

    @NotBlank
    @Size(max = 100, message = "글 내용 100자 초과")
    private String title;

    @NotBlank
    @Size(max = 100, message = "상품명 30자 초과")
    private String itemName;

    @NotBlank
    private String price;

    private Integer itemCategoryId;

    @NotNull(message = "상품이미지를 최소 하나를 등록해야합니다.")
    private List<MultipartFile> fileInput;

    @NotNull
    @Size(max = 100, message = "글 내용 3000자 초과")
    private String content;

    private Boolean isMegaphone;

    private Boolean isAuction;

    @Future
    private LocalDate returnDate;

    @Future
    private LocalDate deadline;

    @NotNull(message = "거래할 장소를 클릭해주세요")
    private Double latitude;

    @NotNull(message = "거래할 장소를 클릭해주세요")
    private Double longitude;

    @NotNull
    private String writer;

}
