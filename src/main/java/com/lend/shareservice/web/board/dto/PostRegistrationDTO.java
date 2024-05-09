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
    private Integer itemCategoryId;

    @NotBlank(message = "글 제목을 입력해주세요")
    @Size(max = 100, message = "글 제목 100자 초과")
    private String title;

    @NotBlank(message = "상품명을 입력해주세요")
    @Size(max = 100, message = "상품명 30자 초과")
    private String itemName;

    @NotBlank(message = "가격을 입력해주세요")
    private String price;

    private String maxPrice;
    @AssertTrue(message = "경매 최고가를 입력해주세요")
    private boolean isMaxPriceSetForAuctions() {
        return !Boolean.TRUE.equals(isAuction) || maxPrice != null && !maxPrice.isEmpty() && !maxPrice.isBlank();
    }

    private List<MultipartFile> fileInput;

    @NotBlank(message = "글 내용을 입력해주세요")
    @Size(max = 3000, message = "글 내용 3000자 초과")
    private String content;

    private Boolean isMegaphone;

    private Boolean isAuction;

    @Future
    private LocalDate returnDate;

    @Future
    private LocalDate deadline;

    @AssertTrue(message = "경매 날짜를 입력해주세요")
    private boolean isDeadlineSetForAuctions() {
        return !Boolean.TRUE.equals(isAuction) || deadline != null;
    }

    @NotNull(message = "거래할 장소를 클릭해주세요")
    private Double latitude;

    @NotNull(message = "거래할 장소를 클릭해주세요")
    private Double longitude;

    @NotNull
    private String writer;

}
